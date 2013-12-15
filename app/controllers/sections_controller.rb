class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  def new
    @section = Section.new
    @section.id_for_menu = params[:menu_id]
    #@id_for_menu = params[:menu_id]
  end

  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        format.html{ redirect_to edit_section_path(@section), :notice => 'Section was successfully creates.' }
      else
        #@id_for_menu = @section.id_for_menu
        format.html{ render action: 'new' }
        #format.html{ redirect_to new_menu_section_path(@section.id_for_menu) }
      end
    end
  end

  def edit

  end

  def update

  end

  private

  def set_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:name, :description, :id_for_menu)
  end
end