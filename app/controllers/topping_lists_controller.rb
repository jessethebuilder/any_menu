class ToppingListsController < ApplicationController
  before_action :set_topping_list, only: [:show, :edit, :update, :destroy]

  # GET /topping_lists
  # GET /topping_lists.json
  def index
    @topping_lists = ToppingList.all
  end

  # GET /topping_lists/1
  # GET /topping_lists/1.json
  def show
  end

  # GET /topping_lists/new
  def new
    @topping_list = ToppingList.new
  end

  # GET /topping_lists/1/edit
  def edit
  end

  # POST /topping_lists
  # POST /topping_lists.json
  def create
    @topping_list = ToppingList.new(topping_list_params)

    respond_to do |format|
      if @topping_list.save
        format.html { redirect_to @topping_list, notice: 'Topping list was successfully created.' }
        format.json { render action: 'show', status: :created, location: @topping_list }
      else
        format.html { render action: 'new' }
        format.json { render json: @topping_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topping_lists/1
  # PATCH/PUT /topping_lists/1.json
  def update
    respond_to do |format|
      if @topping_list.update(topping_list_params)
        format.html { redirect_to @topping_list, notice: 'Topping list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @topping_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topping_lists/1
  # DELETE /topping_lists/1.json
  def destroy
    @topping_list.destroy
    respond_to do |format|
      format.html { redirect_to topping_lists_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topping_list
      @topping_list = ToppingList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topping_list_params
      params.require(:topping_list).permit(:name, :description)
    end
end
