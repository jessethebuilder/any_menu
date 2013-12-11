class CreateSectionalization < ActiveRecord::Migration
  def change
    create_table :sectionalizations do |t|
      t.integer :menu_id
      t.integer :section_id

      t.timestamps
    end
  end
end
