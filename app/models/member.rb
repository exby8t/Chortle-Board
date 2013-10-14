class Member < ActiveRecord::Base
  extend FriendlyId
  friendly_id :full_name, use: :slugged
  belongs_to :family
  belongs_to :member_type

  attr_accessible :birthdate, :email, :first_name, :last_name, :password, :family_id, :member_type_id

  def full_name
  	"#{first_name} #{last_name}"
  end

end

