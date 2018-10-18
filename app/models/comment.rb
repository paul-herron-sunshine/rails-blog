class Comment < ApplicationRecord

  # dependencies
  belongs_to :user
  belongs_to :post

  # validation
  validates :body,  presence: true

end
