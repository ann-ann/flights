class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.datetime :departure_time
      t.datetime :arrival_time
      t.string :carrier
      t.string :origin
      t.string :destination
      t.integer :duration
      t.float :distance
    end
  end
end

