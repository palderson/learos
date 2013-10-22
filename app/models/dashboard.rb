class Dashboard < ActiveRecord::Base
  belongs_to :project
  attr_accessible
  serialize :data, ActiveRecord::Coders::Hstore

  acts_as_commentable
end
