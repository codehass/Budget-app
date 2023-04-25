class EntitiesController < ApplicationController
  before_action :set_entity, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /entities or /entities.json
  def index
    @entities = Entity.where(user_id: current_user.id)
  end

  # GET /entities/1 or /entities/1.json
  def show
  end

  # GET /entities/new
  def new
    @entity = Entity.new
    @groups = Group.all
    @purchases = Purchase.new
  end

  # GET /entities/1/edit
  def edit
  end

  # POST /entities or /entities.json
  def create
    @entity = Entity.new(entity_params)
    @entity.author = current_user
    @entity.user_id = current_user.id 
    
    if @entity.save
      Purchase.create(group_id: entity_params[:group_id], entity_id: @entity.id)
      flash[:notice] = 'Purchase created successfully'
      redirect_to entities_path
    else
      render :new, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /entities/1 or /entities/1.json
  def update
    respond_to do |format|
      if @entity.update(entity_params)
        format.html { redirect_to entity_url(@entity), notice: "Entity was successfully updated." }
        format.json { render :show, status: :ok, location: @entity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1 or /entities/1.json
  def destroy
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to entities_url, notice: "Entity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entity
      @entity = Entity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entity_params
      params.require(:entity).permit(:author, :name, :amount, :user_id, :group_id)
    end
end
