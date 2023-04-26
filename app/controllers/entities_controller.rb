class EntitiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @entity = Entity.new
    @purchases = Purchase.new
    @groups = Group.where(user_id: current_user.id)
  end

  def create
    @entity = Entity.new(
      name: permitted[:name], user_id: permitted[:user_id], amount: permitted[:amount])
      @entity.user_id = current_user.id
    if @entity.save
      @purchase = Purchase.create(group_id: permitted[:group_id], entity_id: @entity.id)
      flash[:notice] = 'Transaction created successfully'
      redirect_to user_group_path(current_user, permitted[:group_id])
    else
      flash[:alert] = 'Error: Could not create a transaction'
      redirect_to new_entity_path
    end
  end

  private

  def permitted
    params.require(:entity).permit(:user_id, :name, :amount, :group_id)
  end
end