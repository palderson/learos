class AddMarketingAttachmentsToMarketings < ActiveRecord::Migration
  def change
  	    add_column :marketings, :file_url, :string
  end

  def down
    remove_column :marketings, :file_url
  end
end