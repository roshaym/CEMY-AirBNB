class RenameLocationToAddressInProperties < ActiveRecord::Migration[7.1]
  def change
    rename_column :properties, :location, :address
  end
end
