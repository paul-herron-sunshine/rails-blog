class Message < ApplicationRecord
  validates :body,  presence: true

  def mark_as_seen
    update_attribute(:seen, true)
    update_attribute(:seen_time, Time.now)
  end
end
