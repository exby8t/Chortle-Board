require 'spec_helper'
require 'date'
require 'pp'

describe Scheduler do

  before(:all) do 

  	@family = FactoryGirl.create(:family, {name: "test fam"})
  	@cat1 = FactoryGirl.create(:category, {name: "monthly"})
  	@cat2 = FactoryGirl.create(:category, {name: "weekly"})
  	
  	@i_m = FactoryGirl.create(:interval, {name: "Monthly"})
  	@i_w = FactoryGirl.create(:interval, {name: "Weekly"})
    @i_d = FactoryGirl.create(:interval, {name: "Daily"})

  	@task1 = FactoryGirl.create(:task, {name: "monthly task", interval_id: @i_m.id, category_id: @cat1.id})
  	@task2 = FactoryGirl.create(:task, {name: "first weekly task", interval_id: @i_w.id, category_id: @cat2.id})
  	@task3 = FactoryGirl.create(:task, {name: "second weekly task", interval_id: @i_w.id, category_id: @cat2.id})
    @task4 = FactoryGirl.create(:task, {name: "daily task", interval_id: @i_d.id, category_id: @cat2.id})
  end

  after(:all) do
  	@cat1.destroy
  	@cat2.destroy

	  @i_m.destroy
  	@i_w.destroy
    @i_d.destroy

  	@task1.destroy
  	@task2.destroy
  	@task3.destroy
    @task4.destroy

  	@family.destroy

  end

  before(:each) do
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
  	expect(ts[:y]).to eq 2013
  	expect(ts[:m]).to eq 10
  	expect(ts[:w]).to eq date.cweek	
  	expect(ts[:d]).to eq time.wday

  end


  it "should create todos for each task" do 
  	
  	@scheduler.generate_todos
    
    today = Date.today
  	todos = Todo.all 
  	
    pp todos

    expect(todos.count).to eq 4
  	#validate the first task which is monthly
  	expect(todos.first.family.name).to eq "test fam"
  	expect(todos.first.year).to eq today.year
    expect(todos.first.month).to eq today.month
  	expect(todos.first.week).to be_nil
    expect(todos.first.day).to be_nil
  	
    #validate the second
  	expect(todos[1].family.name).to eq "test fam"
  	expect(todos[1].week).to eq today.cweek
  	expect(todos[1].day).to be_nil
    
    expect(todos[3].day).to eq today.wday
  end

 	  it "should not create 3 more if already found" do 
 	  	
 	  	@scheduler.generate_todos
  		todos = Todo.all 
  		expect(todos.count).to eq 4

  	end




end
