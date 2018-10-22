class AddViewsNumberToUserModel < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :views, :integer, default: 0
  end
end
