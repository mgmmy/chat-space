class Api::MessagesController < ApplicationController
  before_action :set_group

  def index
    @messages = Message.all
    respond_to do |format|
      format.html { redirect_to group_messages_path }
      format.json { @new_messages = @group.messages.where('id > ?', params[:id]) }
    end
  end

  private

  def message_params
    params.require(:message).permit(:message, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

end
