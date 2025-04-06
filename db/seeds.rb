require 'date'

ActiveRecord::Base.transaction do
  50.times do |i|
    villa = Villa.create!(name: "Villa #{i + 1}")

    (Date.new(2025, 1, 1)..Date.new(2025, 12, 31)).each do |date|
      villa.villa_calendars.create!(
        date: date,
        price: rand(30_000..50_000),
        available: [true, true, true, false].sample
      )
    end
  end
end
