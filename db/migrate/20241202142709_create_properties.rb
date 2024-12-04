class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.integer :rating
      t.string :location
      t.string :price_per_night
      t.string :availability
      t.text :description

      t.timestamps
    end
  end
end
