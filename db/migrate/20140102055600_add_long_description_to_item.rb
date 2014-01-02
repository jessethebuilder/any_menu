class AddLongDescriptionToItem < ActiveRecord::Migration
  def change
    add_column :items, :long_description, :text
  end
end
