class CreateBookingfeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :bookingfeatures do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.date :check_in_date
      t.date :check_out_date
      t.decimal :total_price
      t.string :status

      t.timestamps
    end
  end
end
