class RemoveUserIdToProperties < ActiveRecord::Migration[7.1]
  def change
    remove_reference :properties, :user_id, index: true
  end
end
