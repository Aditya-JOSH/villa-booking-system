class VillasController < ApplicationController
  before_action :set_date_range, only: [:index, :availability]

  def index
    villas = Villa.includes(:villa_calendars).find_each.map do |villa|
      calendars = calendars_for(villa)
      {
        id: villa.id,
        name: villa.name,
        average_price_per_night: (calendars.sum(&:price).to_f / @nights.size).round(2),
        available: available_for_range?(calendars)
      }
    end

    render json: sort_villas(villas)
  rescue => e
    render json: { error: "Something went wrong: #{e.message}" }, status: :internal_server_error
  end

  def availability
    villa = Villa.find_by(id: params[:id])
    return render json: { error: "Villa not found" }, status: :not_found unless villa

    calendars = calendars_for(villa)

    if available_for_range?(calendars)
      subtotal = calendars.sum(&:price).to_f
      gst = (0.18 * subtotal).round
      total = (subtotal + gst).round

      render json: {
        available: true,
        subtotal: subtotal.round(2),
        gst: gst,
        total_price: total
      }
    else
      render json: {
        available: false,
        subtotal: nil,
        gst: nil,
        total_price: nil
      }
    end
  rescue => e
    render json: { error: "Something went wrong: #{e.message}" }, status: :internal_server_error
  end

  private

  def set_date_range
    checkin_date = Date.parse(params[:checkin_date]) rescue nil
    checkout_date = Date.parse(params[:checkout_date]) rescue nil

    if checkin_date.blank? || checkout_date.blank? || checkin_date >= checkout_date
      render json: { error: "Invalid or missing check-in/check-out dates" }, status: :unprocessable_entity
    else
      @nights = (checkin_date...checkout_date).to_a
    end
  end

  def calendars_for(villa)
    villa.villa_calendars.select { |cal| @nights.include?(cal.date) }
  end

  def available_for_range?(calendars)
    calendars.size == @nights.size && calendars.all?(&:available)
  end

  def sort_villas(villas)
    if params[:sort_price] == "low_to_high"
      villas.sort_by { |v| v[:average_price_per_night] }
    elsif params[:sort_price] == "high_to_low"
      villas.sort_by { |v| -v[:average_price_per_night] }
    elsif ActiveModel::Type::Boolean.new.cast(params[:sort_availability])
      villas.sort_by { |v| v[:available] ? 0 : 1 }
    else
      villas
    end
  end
end
