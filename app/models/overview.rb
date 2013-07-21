class Overview < ActiveRecord::Base
  belongs_to :project
  attr_accessible :elevator_pitch, :value_proposition, :internal_motivations, :file_url
end
