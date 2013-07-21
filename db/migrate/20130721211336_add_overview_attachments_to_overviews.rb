class AddOverviewAttachmentsToOverviews < ActiveRecord::Migration
  def change
  	    add_column :overviews, :file_url, :string
  end

  def down
    remove_column :overviews, :file_url
  end
end