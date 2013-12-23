class AddMenuPackageToStore < ActiveRecord::Migration
  def change
    add_column :stores, :menu_package, :string
  end
end
