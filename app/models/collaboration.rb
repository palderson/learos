class Collaboration < ActiveRecord::Base
  attr_accessible :user_id, :project_id
  belongs_to :user
  belongs_to :project

  attr_accessor :email, :name
end
