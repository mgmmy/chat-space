class GroupsController < ApplicationController
  before_action :set_group, only: %i(edit update)
  before_action :authorize_article, only: %i(index new create)
  after_action :verify_authorized

  def index
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.create_activity :create, owner: current_user
      redirect_to root_path, notice: "グループを作成しました"
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      @group.create_activity :update, owner: current_user
      redirect_to group_messages_path(@group), notice: "グループを更新しました"
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def set_group
    @group = Group.find(params[:id])
    authorize @group
  end

  def authorize_group
    authorize Group
  end

end
