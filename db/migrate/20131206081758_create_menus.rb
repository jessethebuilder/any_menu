class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description
      t.integer :store_id
      t.text :section_order
      t.integer :hours_available_id

      t.timestamps
    end
  end
end
