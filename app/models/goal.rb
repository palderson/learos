class Goal < ActiveRecord::Base
  belongs_to :project
  attr_accessible :description
end
