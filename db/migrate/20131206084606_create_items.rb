class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.boolean :tax_exempt
      t.boolean :dont_deliver
      t.integer :topping_list_id
      t.integer :section_id
      t.float :cost

      t.timestamps
    end
  end
end
