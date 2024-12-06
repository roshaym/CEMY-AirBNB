class RenameStartDateAndEndDateToCheckInAndCheckOut < ActiveRecord::Migration[6.0]
  def change
    # Since the columns already exist, we can skip renaming
    # remove_column :bookings, :start_date  # Only if you want to remove start_date
    # remove_column :bookings, :end_date    # Only if you want to remove end_date
  end
end
