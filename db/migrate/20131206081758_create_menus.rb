class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description
      t.integer :store_id
      t.text :section_order


      t.timestamps
    end
  end
end
