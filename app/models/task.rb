class Task < ActiveRecord::Base
  belongs_to :interval
  belongs_to :category
  belongs_to :family
  attr_accessible :age_limit, :is_active, :name, :points, :category_id, :interval_id, :family_id

  #default_scope { where(is_active: true)}
  scope :active, -> { where(is_active: true)}
end
