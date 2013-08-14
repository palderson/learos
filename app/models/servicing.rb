class Servicing < ActiveRecord::Base
  belongs_to :project
  attr_accessible :description, :data
  serialize :data, ActiveRecord::Coders::Hstore

  acts_as_commentable
end
