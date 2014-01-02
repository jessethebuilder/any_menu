class AddFacebookAppIdToStore < ActiveRecord::Migration
  def change
    add_column :stores, :facebook_app_id, :string
  end
end
