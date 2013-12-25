class AddCompletedAndPaidToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :completed, :boolean, :default => false
    add_column :orders, :paid, :boolean, :default => false
  end
end
