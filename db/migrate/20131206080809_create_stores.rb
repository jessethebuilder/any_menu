class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.text :description
      t.boolean :delivers
      t.float :sales_tax_rate
      t.integer :hours_available_id

      t.timestamps
    end
  end
end
