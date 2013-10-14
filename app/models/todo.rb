class Todo < ActiveRecord::Base
  belongs_to :member
  belongs_to :task
  belongs_to :family
  attr_accessible :day, :is_completed, :month, :week, :year
end
