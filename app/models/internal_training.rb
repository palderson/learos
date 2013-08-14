class InternalTraining < ActiveRecord::Base
  belongs_to :project
  attr_accessible :individual_training_materials, :group_training_materials, :file_url, :data
  serialize :data, ActiveRecord::Coders::Hstore

  acts_as_commentable
end
