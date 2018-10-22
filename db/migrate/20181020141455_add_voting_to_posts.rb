class AddVotingToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :votes, :integer
  end
end
