class CreateVillas < ActiveRecord::Migration[8.0]
  def change
    create_table :villas do |t|
      t.string :name

      t.timestamps
    end
  end
end
