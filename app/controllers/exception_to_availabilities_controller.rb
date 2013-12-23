class ExceptionToAvailabilitiesController < ApplicationController
  before_action :set_exception_to_availability, only: [:edit, :update, :destroy]
  before_action :set_hours_available, :only => [:new, :edit, :create, :update, :destroy]

 def index
    @exception_to_availabilities = ExceptionToAvailability.all
  end

  def new
    @exception_to_availability = ExceptionToAvailability.new
  end

  def edit
  end

  def create
    @exception_to_availability = ExceptionToAvailability.new(exception_to_availability_params)

    respond_to do |format|
      if @exception_to_availability.save
        #format.js
        format.html{ redirect_to @hours_available.path_back }
      else
        #format.js { render :action => 'new' }
        format.html{ render :action => 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @exception_to_availability.update(exception_to_availability_params)
        #format.js
        format.html{ redirect_to @hours_available.path_back }
      else
       #format.js { render :action => 'edit'}
       format.html{ render :action => 'edit' }
      end
    end
  end

  def destroy
    @exception_to_availability.destroy
    respond_to do |format|
      format.html { redirect_to @hours_available.path_back }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exception_to_availability
      @exception_to_availability = ExceptionToAvailability.find(params[:id])
    end

    def set_hours_available
      @hours_available = HoursAvailable.find(params[:hours_available_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exception_to_availability_params
      params.require(:exception_to_availability).permit(:name, :hours_available_id, :open, :close, :reoccurring)
    end
end
