class HoursAvailablesController < ApplicationController
  before_action :set_hours_available, only: [:show, :edit, :update, :destroy]


  private

  def set_hours_available
    @hours_available = HoursAvailable.find(params[:id])
  end

  def hours_available_params
    params.require(:item).permit(:sunday_open, :sunday_close, :monday_open, :monday_close, :tuesday_open, :tuesday_close,
                                 :wednesday_open, :wednesday_close, :thursday_open, :thursday_close, :friday_open, :friday_close,
                                 :saturday_open, :saturday_close)
  end

end