class MemberType < ActiveRecord::Base
  attr_accessible :name
  has_many :members

  def to_s
  	name
  end
end
