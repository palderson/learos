class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  attr_accessor :email
  # attr_accessible :title, :body
end
