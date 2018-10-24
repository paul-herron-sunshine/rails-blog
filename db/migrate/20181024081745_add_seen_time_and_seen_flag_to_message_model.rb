class AddSeenTimeAndSeenFlagToMessageModel < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :seen_time, :datetime
    add_column :messages, :seen, :boolean, default: false
  end
end
