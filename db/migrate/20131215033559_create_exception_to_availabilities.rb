class CreateExceptionToAvailabilities < ActiveRecord::Migration
  def change
    create_table :exception_to_availabilities do |t|
      t.string :name
      t.integer :hours_available_id
      t.datetime :open
      t.datetime :close
      t.boolean :reoccurring
      t.boolean :changing_dates

      t.timestamps
    end
  end
end
