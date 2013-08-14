class ClientTraining < ActiveRecord::Base
  belongs_to :project
  attr_accessible :company_training_materials, :user_training_materials, :file_url, :data
  serialize :data, ActiveRecord::Coders::Hstore

  acts_as_commentable
end
