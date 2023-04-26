class GroupsController < ApplicationController
  load_and_authorize_resource
  # GET /groups or /groups.json
  def index
    @groups = Group.where(user_id: current_user.id)
  end

  # GET /groups/1 or /groups/1.json
  def show
    @group = Group.find(params[:id])
    @purchases = Purchase.where(['group_id = :id', { id: params[:id].to_s }]).order(created_at: :desc)
    # @total = @category.purchases.sum { |item| item.entity.amount }
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id

    if @group.save
      flash[:notice] = 'Category created successfully'
      redirect_to groups_path
    else
      redirect_to groups_path(current_user)
    end
    
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name, :icon)
    end
end
