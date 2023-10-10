class MessagesController < ApplicationController
  def show
    @message = Message.new
    @messages = Message.where(sender_id: current_user.id, reciever_id: params[:user_id])
      .or(Message.where(sender_id: params[:user_id], reciever_id: current_user.id))

      @reciever_name = User.find(params[:user_id]).name
  end

  def create
    message = Message.new(message_params)
    message.sender_id = current_user.id
    message.reciever_id = params[:user_id]
    if message.save() then
      redirect_to request.referer
    else
      @message = message
      @messages = Message.where(sender_id: current_user.id, reciever_id: params[:user_id])
        .or(Message.where(sender_id: params[:user_id], reciever_id: current_user.id))
  
        @reciever_name = User.find(params[:user_id]).name
      render "show"
    end

  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
