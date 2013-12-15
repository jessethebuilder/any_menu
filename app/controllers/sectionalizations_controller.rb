class SectionalizationsController < ApplicationController
  before_action :set_sectionalization, :only => [:destroy]

  def destroy
    @sectionalization.destroy
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  private

  def set_sectionalization
    @sectionalization = Sectionalization.find(params[:id])
  end
end