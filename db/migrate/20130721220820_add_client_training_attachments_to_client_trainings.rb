class AddClientTrainingAttachmentsToClientTrainings < ActiveRecord::Migration
  def change
  	    add_column :client_trainings, :file_url, :string
  end

  def down
    remove_column :client_trainings, :file_url
  end
end