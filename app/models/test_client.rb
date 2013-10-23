class TestClient < ActiveRecord::Base
  belongs_to :project
  attr_accessible :client_1, :client_2, :client_3, :data
  serialize :data, ActiveRecord::Coders::Hstore

  acts_as_commentable
end
