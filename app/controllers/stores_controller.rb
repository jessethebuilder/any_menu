class StoresController < ApplicationController
  include ApplicationHelper
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, :only => [:new, :create, :update, :edit]



  # GET /stores
  # GET /stores.json
  def index
    if store
      if super_user?
        redirect_to edit_store_path(store)
      else
        if store.current_menu
          redirect_to menu_path(store.current_menu)
        else
          redirect_to menus_path, :alert => "#{store.name} is currently closed."
        end
      end
    else
      redirect_to new_store_path
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end
  def edit

  end

  def new
    @store = Store.new
    @store.build_hours_available
    @store.build_address
    #@store.address = Address.new
  end

  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save!
        format.html { redirect_to edit_store_path(@store), notice: 'Store was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to edit_store_path(@store), notice: 'Store was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :description, :delivers, :dine_in, :sales_tax_rate, :menu_package,
                                    :facebook_app_id, :facebook_secret, :average_wait_time, :phone,
                                    :address_attributes => [:street, :street2, :street3, :city, :state, :zip],
                                    :hours_available_attributes => [:id, :sunday_open, :sunday_close, :monday_open, :monday_close,
                                                                    :tuesday_open, :tuesday_close, :wednesday_open, :wednesday_close,
                                                                    :thursday_open, :thursday_close, :friday_open, :friday_close,
                                                                    :saturday_open, :saturday_close])
    end
end
