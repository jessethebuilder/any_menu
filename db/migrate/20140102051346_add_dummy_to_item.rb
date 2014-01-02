class AddDummyToItem < ActiveRecord::Migration
  def change
    add_column :items, :dummy, :boolean, :default => true
  end
end
