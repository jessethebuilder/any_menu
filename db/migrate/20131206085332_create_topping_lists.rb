class CreateToppingLists < ActiveRecord::Migration
  def change
    create_table :topping_lists do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
