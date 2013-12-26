class AddDiningLocationToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :dining_location, :string
  end
end
