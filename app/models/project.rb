class Project < ActiveRecord::Base
  attr_accessible :title, :overview_attributes

  has_one :overview
  has_many :goals
  accepts_nested_attributes_for :overview

  after_create { self.create_overview }
end
