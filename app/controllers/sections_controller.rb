class SectionsController < ApplicationController
  include ActionView::Helpers::UrlHelper

  before_action :set_section, only: [:show, :edit, :update, :destroy, :add, :remove, :move]
  before_action :set_menu, :only => [:new, :edit, :create, :update, :destroy, :add, :remove, :move]

  # add, remove, move #######################################################
  def add
    @menu.sections << @section
    redirect_to edit_menu_path(@menu)
  end

  def remove
    @menu.sections.delete(@section)
    redirect_to edit_menu_path(@menu)
  end

  def move
    velocity = params[:velocity]
    @menu.move_section(@section, velocity)
    redirect_to edit_menu_path(@menu)
  end
  # add, remove, move #######################################################

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
          if @menu
            redirect_to edit_menu_section_path(@menu, @section), :notice => 'Section was successfully created.'
          else
            redirect_to edit_section_path(@section), :notice => 'Section was successfully created.'
          end
        end
      else
        set_form_target
        format.html{ render action: 'new' }
      end
    end
  end

  def edit
    set_form_target
  end

  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html do
          if @menu
            redirect_to edit_menu_path(@menu), :notice => "#{@section.name} was successfully updated."
          else
            redirect_to sections_path, :notice => "#{@section.name} was successfully updated."
          end
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

  def set_form_target
    if @menu
      @form_target = [@menu, @section]
      @link_back = link_to("(return to #{@menu.name})", edit_menu_path(@menu)).html_safe
    else
      @form_target = @section
      @link_back = link_to("(return to Sections)", sections_path).html_safe
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