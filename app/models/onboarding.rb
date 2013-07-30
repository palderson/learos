class Onboarding < ActiveRecord::Base
  belongs_to :project
  attr_accessible :step_one, :step_two, :step_three, :step_four, :step_five

  acts_as_commentable
end
