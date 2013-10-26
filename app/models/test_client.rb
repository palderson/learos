class TestClient < ActiveRecord::Base
  belongs_to :project
  attr_accessible :first, :second, :third, :data
  serialize :data, ActiveRecord::Coders::Hstore

  acts_as_commentable
end
