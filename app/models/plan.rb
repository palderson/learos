class Plan < ActiveRecord::Base
  belongs_to :project
  attr_accessible :attention, :interest, :desire, :action
end
