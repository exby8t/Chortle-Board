class Task < ActiveRecord::Base
  belongs_to :interval
  belongs_to :category
  attr_accessible :age_limit, :is_active, :name, :points, :category_id, :interval_id
end
