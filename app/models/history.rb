class History < ActiveRecord::Base
  belongs_to :member
  attr_accessible :points, :quota, :week, :year

  def week_of
  	Date.commercial(year, week)
  end

end
