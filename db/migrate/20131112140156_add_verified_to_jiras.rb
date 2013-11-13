class AddVerifiedToJiras < ActiveRecord::Migration
  def change
    add_column :jiras, :verified, :boolean, default: false
    add_column :jiras, :public_key, :text
  end
end
