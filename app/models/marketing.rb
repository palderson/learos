class Marketing < ActiveRecord::Base
  belongs_to :project
  attr_accessible :overview, :external_messaging, :internal_messaging, :marketing_budget, :alpha_invite_email, :beta_invite_email, :file_url

  acts_as_commentable
end
