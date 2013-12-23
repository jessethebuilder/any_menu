class AddItemOrderToSection < ActiveRecord::Migration
  def change
    add_column :sections, :item_order, :text
  end
end
