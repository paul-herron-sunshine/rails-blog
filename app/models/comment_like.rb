class CommentLike < ApplicationRecord

  belongs_to :comment
  belongs_to :user

  # validation
  validates :user_id, :comment_id, presence: true, uniqueness: { scope: [:user_id, :comment_id] }

end
