class Family < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  attr_accessible :name
  has_many :tasks
  has_many :members

  def to_s
  	name
  end

end
