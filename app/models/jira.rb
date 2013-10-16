class Jira < ActiveRecord::Base
  attr_accessible :consumer_key, :private_key, :site_url, :oauth_verifier, :user_id

  belongs_to :user
end
