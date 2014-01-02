class AddPlaceOrderAtToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :place_order_at, :time
  end
end
