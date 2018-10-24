class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  # validation
  validates :body,  presence: true
  validates :title,  presence: true
end
