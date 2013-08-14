class Plan < ActiveRecord::Base
  belongs_to :project
  attr_accessible :attention, :interest, :desire, :action, :plan, :data
  serialize :data, ActiveRecord::Coders::Hstore

  acts_as_commentable
end
