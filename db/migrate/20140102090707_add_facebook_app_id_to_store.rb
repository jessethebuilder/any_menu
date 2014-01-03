class AddFacebookAppIdToStore < ActiveRecord::Migration
  def change
    add_column :stores, :facebook_app_id, :string
    add_column :stores, :facebook_secret, :string
  end
end
