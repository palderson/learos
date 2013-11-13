class Jira < ActiveRecord::Base
  attr_accessible :consumer_key, :private_key, :public_key, :site_url, :access_token, :access_key, :verified, :user_id
  attr_accessor :oauth_verifier
  belongs_to :user

  validates :site_url, presence: true
end
