require 'spec_helper'

describe History do
  

  it "returns the date for a week" do 
  	today = Date.today
  	year = today.year
  	week = today.cweek


  	result = Date.commercial(year, week)

  	history = FactoryGirl.build(:history, {member_id: 1, week: 45, year: year})
  	expect(history.week_of).to eq result
  	
  end
end
