class ClientTraining < ActiveRecord::Base
  belongs_to :project
  attr_accessible :company_training_materials, :user_training_materials
end
