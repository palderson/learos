class Onboarding < ActiveRecord::Base
  belongs_to :project
  attr_accessible :step_one, :step_two, :step_three, :step_four, :step_five, :data
  serialize :data, ActiveRecord::Coders::Hstore

  acts_as_commentable
end
