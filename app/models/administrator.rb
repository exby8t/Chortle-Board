class Administrator < ActiveRecord::Base
  attr_accessible :email, :password
end
