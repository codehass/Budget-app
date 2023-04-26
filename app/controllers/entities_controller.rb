class EntitiesController < ApplicationController
  load_and_authorize_resource

  # GET /entities or /entities.json
  def index
    @entities = Entity.where(user_id: current_user.id)
  end

  # GET /entities/new
  def new
    @entity = Entity.new
    @groups = Group.all
    @purchases = Purchase.new
  end

  # POST /entities or /entities.json
  def create
    @entity = Entity.new(name: entity_params[:name], author: entity_params[:author], amount: entity_params[:amount])
    @entity.author = current_user.name
    @entity.user_id = current_user.id 
    
    if @entity.save
      @purchase = Purchase.create(group_id: entity_params[:group_id], entity_id: @entity.id)
      flash[:notice] = 'Purchase created successfully'

      redirect_to group_path(current_user, entity_params[:group_id])
    else
      flash[:alert] = 'Error: Could not create a transaction'
      redirect_to new_entity_path
    end

  end

  private
    # Only allow a list of trusted parameters through.
    def entity_params
      params.require(:entity).permit(:author, :name, :amount, :user_id)
    end
end
