class AddVerifiedToJiras < ActiveRecord::Migration
  def change
    add_column :jiras, :verified, :boolean, default: false
  end
end
