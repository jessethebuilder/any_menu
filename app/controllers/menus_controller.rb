class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    @menus = Menu.all
  end

  def show
  end

  def new
    #todo add active menu logic
    if Menu.count > 0 && Store.first.menu_package == 'single_menu'
      redirect_to :back, :notice => 'Multiple menus are not available yet. Coming soon.'
    end

    @menu = Menu.new
    @menu.hours_available = Store.first.hours_available.dup
  end

  def edit

  end

  def create
    @menu = Menu.new(menu_params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to edit_menu_path(@menu), notice: 'Menu was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to edit_menu_path(@menu), notice: 'Menu was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to edit_store_path(Store.first) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :description, :store_id,
                                   :hours_available_attributes => [:id, :sunday_open, :sunday_close, :monday_open, :monday_close,
                                                                   :tuesday_open, :tuesday_close, :wednesday_open, :wednesday_close,
                                                                   :thursday_open, :thursday_close, :friday_open, :friday_close,
                                                                   :saturday_open, :saturday_close])
    end

  #todo add dont_deliver? to item
end
