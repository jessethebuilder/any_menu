class ItemsController < ApplicationController
   before_action :set_item_and_section
  before_action :set_menu
  #before_action :set_section, :only => [:new, :edit]

  def add
    @section.items << @item
    if @menu
      redirect_to edit_menu_section_path(@menu, @section)
    else
      redirect_to edit_section_path(@menu, @section)
    end
  end

  def remove
    @section.items.delete(@item)
    if @menu
      redirect_to edit_menu_section_path(@menu, @section)
    else
      redirect_to edit_section_path(@section)
    end
  end

  def move
    @section.move_item(@item, params[:velocity])
    if @menu
      redirect_to edit_menu_section_path(@menu, @section)
    else
      redirect_to edit_section_path(@section)
    end
  end

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
    @section = Section.find(params[:section_id])
    set_form_target
  end

  def edit
    @section = Section.find(params[:section_id])
    set_form_target
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @section.items << @item
        format.html do
          if @menu
            redirect_to edit_menu_section_path(@menu, @section), :notice => "#{@item.name} was successfully created."
          else
            redirect_to edit_section_path(@section), :notice => "#{@item.name} was successfully created."
          end
        end
      else
        set_form_target
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html do
          if @menu
            redirect_to edit_menu_section_path(@menu, @section), notice: "#{@item.name} was successfully updated."
          else
            redirect_to edit_section_path(@section), :notice => "#{@item.name} was successfully updated"
          end
        end
      else
        set_form_target
        format.html { render action: 'edit' }
        #format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy
    if @menu
      redirect_to edit_menu_section_path(@menu, @section)
    else
      redirect_to section_items_path(@section)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_and_section
      @item = Item.find(params[:id]) if params[:id]
      @section = Section.find(params[:section_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :tax_exempt, :dont_deliver, :topping_list_id, :cost)
    end

  # add, move, remove #########################################3
  def set_menu
    @menu = Menu.find(params[:menu_id]) if params[:menu_id]
  end

  def set_form_target
    if @menu
      @form_target = [@menu, @section, @item]
      @link_back = link_to("(return to #{@section.name})", edit_menu_section_path(@menu, @section)).html_safe
    else
      @form_target = [@section, @item]
      @link_back = link_to("(return to Items)", section_items_path(@section)).html_safe
    end
  end

end
