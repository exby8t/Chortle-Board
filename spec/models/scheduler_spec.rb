require 'spec_helper'
require 'date'
require 'pp'

describe Scheduler do

=begin
  Config generates the following models
    == 1 Family
    == 2 Catogories
    == All intervals

    == 4 Tasks
        == 1 Monthly
        == 2 Weekly
        == 1 daily 

=end

  before(:each) do
    @today = Date.parse('5/11/2013')
  	@scheduler = Scheduler.new(@family)
  end

  it "should inject a family as a dependent" do
    fam = @scheduler.family
    expect(fam).to be_kind_of Family
  end


  it "should get y,m,d from date" do
  	ts = @scheduler.ts_params
  	time = Time.new
  	date = Date.today
  	expect(ts[:y]).to eq date.year
  	expect(ts[:m]).to eq date.month
  	expect(ts[:w]).to eq date.cweek	
  	expect(ts[:d]).to eq time.wday

  end


  it "should create todos for each task" do 
  	
    
    @scheduler.generate_todos(@today)
    
  	todos = Todo.all 
  	
    #pp todos
    #create two weeks of todos
    #there should be 19 todos, 1 monthly, 4 weekly, and 14 daily
    expect(todos.count).to eq 19
  	
    #validate the first task which is monthly
  	expect(todos.first.family.name).to eq "test fam"
  	expect(todos.first.year).to eq @today.year
    expect(todos.first.month).to eq @today.month
  	expect(todos.first.week).to be_nil
    expect(todos.first.day).to be_nil
  	
    #validate the second
  	expect(todos[1].family.name).to eq "test fam"
  	expect(todos[1].week).to eq @today.cweek
  	expect(todos[1].day).to be_nil
    
    expect(todos[5].day).to eq @today.wday
    #pp todos.last
    #expect(todos.last.day).to eq (today + 14.days).mday

    pp Todo.all
    
    
  end

  it "should not create 3 more if already found" do 
  	
   @scheduler.generate_todos(@today)
	 todos = Todo.all 
	 expect(todos.count).to eq 19

  end


it "should get the day of year for the sunday of that week" do 
    
    expected_date = Time.parse('2/11/2013')
    current_date = Time.parse('5/11/2013')
    
    sunday = @scheduler.get_first_day(current_date)

    pp sunday
    expect(sunday).to eq expected_date

  end


end
