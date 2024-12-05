class AddUserIdToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :user_id, :bigint
    add_index :bookings, :user_id
  end
end
