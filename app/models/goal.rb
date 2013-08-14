class Goal < ActiveRecord::Base
  belongs_to :project
  attr_accessible :six_week_goals, :three_month_goals, :six_month_goals, :data
  serialize :data, ActiveRecord::Coders::Hstore

  acts_as_commentable
end
