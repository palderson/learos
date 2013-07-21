class AddInternalTrainingAttachmentsToInternalTrainings < ActiveRecord::Migration
  def change
  	    add_column :internal_trainings, :file_url, :string
  end

  def down
    remove_column :internal_trainings, :file_url
  end
end