class AddAverageWaitTimeToStore < ActiveRecord::Migration
  def change
    add_column :stores, :average_wait_time, :integer
  end
end
