class MessagesController < ApplicationController
  def index
    if logged_in?
      user_ids = []
      @messages = Message.where(sender_id: current_user.id)
      @messages += Message.where(receiver_id: current_user.id)

      @messages.each do |message|
        if message.sender_id == current_user.id
          user_ids << message.receiver_id
        else
          user_ids << message.sender_id
        end
      end

      user_ids = user_ids.uniq

      @users = user_ids.map { |user_id| User.find(user_id) }
    else
      redirect_to login_path
    end
  end

  def create
    if logged_in?
      sender_id = params[:sender_id]
      receiver_id = params[:receiver_id]
      message = params[:message]
      # add message to messages table on the db with the required information
      msg = Message.new(sender_id: sender_id,
                        receiver_id: receiver_id,
                        body: message)
      if msg.save
        flash[:success] = "Message sent successfully"
        redirect_to messages_path(:receiver_id => receiver_id, :sender_id => sender_id)
      else
        flash[:danger] = "Message not sent. Please try again later"
        redirect_to messages_path(:receiver_id => receiver_id, :sender_id => sender_id)
      end
    else
      redirect_to login_path
    end
  end

  def show
    if logged_in?
      @sender_id = params[:sender_id]
      @receiver_id = params[:receiver_id]
      @messages = []
      # check both wys of cummunication
      if Message.exists?(sender_id: @sender_id, receiver_id: @receiver_id)
        @messages = Message.where(sender_id: @sender_id, receiver_id: @receiver_id)
      end
      if Message.exists?(receiver_id: @sender_id, sender_id: @receiver_id)
        @messages += Message.where(receiver_id: @sender_id, sender_id: @receiver_id)
      end

      @messages = @messages.sort {|x, y| y.created_at <=> x.created_at}
    else
      redirect_to login_path
    end
  end
end
