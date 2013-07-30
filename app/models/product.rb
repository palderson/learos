class Product < ActiveRecord::Base
  belongs_to :project
  attr_accessible :description

  acts_as_commentable
end
