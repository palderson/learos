class Profile < ActiveRecord::Base
  belongs_to :project
  attr_accessible :ideal_client, :applicable_client_percentage, :client_motivations, :target_budget, :purchase_decision_maker, :product_user, :data
  serialize :data, ActiveRecord::Coders::Hstore

  acts_as_commentable
end
