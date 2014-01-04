class ChangeApartmentNumberToStreet3OnAddress < ActiveRecord::Migration
  def change
    remove_column :addresses, :apartment_number, :string
    add_column :addresses, :street3, :string
  end
end
