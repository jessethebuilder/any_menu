class OrderItemsController < ApplicationController
  include ApplicationHelper
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]
  before_action :set_order, :only => [:update, :destroy]

  # GET /order_items
  # GET /order_items.json
  def index
    @order_items = OrderItem.all
  end

  # GET /order_items/1
  # GET /order_items/1.json
  def show
  end

  # GET /order_items/new
  def new
    @order_item = OrderItem.new
  end

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  # POST /order_items.json
  def create
    @order_item = OrderItem.new(order_item_params)
    respond_to do |format|
      if current_order.order_items << @order_item
        format.html { redirect_to  }
        format.json { render action: 'show', status: :created, location: @order_item }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    @order = @order_item.order
    respond_to do |format|
      if @order_item.update(order_item_params)
        format.html { redirect_to @order_item, notice: 'Order item was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy

    @id_to_destroy = @order_item.id
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to order_items_url }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def set_order
      @order = @order_item.order
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:order_id, :cost, :quantity, :item_id)
    end
end
