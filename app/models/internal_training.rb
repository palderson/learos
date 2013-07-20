class InternalTraining < ActiveRecord::Base
  belongs_to :project
  attr_accessible :individual_training_materials, :group_training_materials
end
