class Rollout < ActiveRecord::Base
  belongs_to :project
  attr_accessible :what_went_well, :what_could_have_gone_better, :what_surprised_you, :lesson_learned, :data
  serialize :data, ActiveRecord::Coders::Hstore

  acts_as_commentable
end
