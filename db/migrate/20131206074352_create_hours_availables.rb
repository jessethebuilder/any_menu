class CreateHoursAvailables < ActiveRecord::Migration
  def change
    create_table :hours_availables do |t|
      %w[sunday monday tuesday wednesday thursday friday saturday].each do |d|
        t.datetime "#{d}_open".to_sym
        t.datetime "#{d}_close".to_sym
        t.datetime "#{d}_open2".to_sym
        t.datetime "#{d}_close2".to_sym

        t.integer :menu_id
      end

      t.timestamps
    end
  end
end
