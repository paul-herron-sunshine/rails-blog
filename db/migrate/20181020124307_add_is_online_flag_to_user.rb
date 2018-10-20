class AddIsOnlineFlagToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_online, :boolean, default: false
  end
end
