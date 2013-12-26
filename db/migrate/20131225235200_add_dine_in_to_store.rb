class AddDineInToStore < ActiveRecord::Migration
  def change
    add_column :stores, :dine_in, :boolean
  end
end
