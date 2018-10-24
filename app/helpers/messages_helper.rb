module MessagesHelper
  def conversation_exists?(user1_id, user2_id)
    if Message.exists?(sender_id: user1_id, receiver_id: user2_id) ||
         Message.exists?(sender_id: user2_id, receiver_id: user1_id)
      true
    else
      false
    end
  end

  def has_unread_mail_generic?(logged_in_user)
    Message.exists?(receiver_id: logged_in_user.id, seen: false) ? true : false
  end

  def has_unread_mail_specific?(logged_in_user, other_user)
    Message.exists?(receiver_id: logged_in_user.id, sender_id: other_user, seen: false) ? true : false
  end
end
