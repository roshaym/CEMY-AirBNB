class RenameCheckInAndCheckOutToStartAndEndInBookings < ActiveRecord::Migration[6.0]
  def change
    rename_column :bookings, :check_in, :start_date
    rename_column :bookings, :check_out, :end_date
  end
end
