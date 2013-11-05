require 'spec_helper'

describe Family do
  
	it "has an array of tasks" do 
		expect(@family.tasks).to be_a Array
	end
	
	it "has an array of membmers" do 
		expect(@family.members).to be_a Array
	end
end
