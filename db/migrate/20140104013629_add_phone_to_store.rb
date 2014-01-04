class AddPhoneToStore < ActiveRecord::Migration
  def change
    add_column :stores, :phone, :string
  end
end
