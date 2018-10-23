class MessagesController < ApplicationController
  def create

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
  end

  def show
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
  end
end
