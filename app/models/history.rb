class History < ActiveRecord::Base
  belongs_to :member
  attr_accessible :points, :quota, :week, :year
end
