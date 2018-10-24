module MessagesHelper
  def conversation_exists?(user1_id, user2_id)
    if Message.exists?(sender_id: user1_id, receiver_id: user2_id) ||
         Message.exists?(sender_id: user2_id, receiver_id: user1_id)
      true
    else
      false
    end
  end
end
