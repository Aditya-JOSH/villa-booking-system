class CreateVillaCalendars < ActiveRecord::Migration[8.0]
  def change
    create_table :villa_calendars do |t|
      t.references :villa, null: false, foreign_key: true
      t.date :date
      t.integer :price
      t.boolean :available

      t.timestamps
    end
  end
end
