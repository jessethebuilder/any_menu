class CreateToppings < ActiveRecord::Migration
  def change
    create_table :toppings do |t|
      t.string :name
      t.text :description
      t.float :cost
      t.integer :topping_list_id

      t.timestamps
    end
  end
end
