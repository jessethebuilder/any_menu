class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :street
      t.string :street2
      t.string :apartment_number
      t.string :city
      t.string :state
      t.string :zip
      t.float :latitude
      t.float :longitude

      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps
    end
  end
end
