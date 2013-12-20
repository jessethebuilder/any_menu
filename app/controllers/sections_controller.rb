class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy, :add]
  before_action :set_menu, :only => [:new, :edit, :create, :update, :destroy, :add]

  def add
    @menu.sections << @section
    redirect_to edit_menu_path(@menu)
  end

  def index
    @sections = Section.all
  end

  def new
    @section = Section.new
    set_form_target
    @other_sections = @menu.sections_not_on_this_menu if @menu
  end

  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        @menu.sections << @section if @menu
        format.html do
          redirect_to after_create_path, :notice => 'Section was successfully created.'
        end
      else
        set_form_target
        format.html{ render action: 'new' }
      end
    end
  end

  def edit
    set_form_target
    if params[:menu_id]
      @sectionalization = Sectionalization.where(:section_id => @section.id).where(:menu_id => params[:menu_id]).first
    end
  end

  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html do
          redirect_to after_update_path, :notice => "#{@section.name} was successfully updated."
        end
      else
        set_form_target
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @section.destroy
    if @menu
      redirect_to edit_menu_path(@menu)
    else
      redirect_to sections_path
    end

  end

  private

  def after_update_path
    if @menu
      edit_menu_path(@menu)
    else
      sections_path
    end
  end

  def after_create_path
    if @menu
      edit_menu_section_path(@menu, @section)
    else
      edit_section_path(@section)
    end
  end

  def set_form_target
    if @menu
      @form_target = [@menu, @section]
    else
      @form_target = @section
    end
  end

  def set_menu
    if params[:menu_id]
      @menu = Menu.find(params[:menu_id])
    end
  end

  def set_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:name, :description)
  end
end