require 'spec_helper'
require 'pp'
require 'date'

describe Todo do

  it "is assigned if a member is attached" do 
    todo = FactoryGirl.build(:todo)
    expect(todo.assigned?).to eq false
  end

  it "is NOT assigned if a member is NOT attached" do 
    member = FactoryGirl.create(:member)
    todo = FactoryGirl.build(:todo, {:member_id => member.id})
    expect(todo.assigned?).to eq true
    member.destroy
  end

  it "has a completed and incompleted scope" do 

    FactoryGirl.create(:todo, {:is_completed => true})
    FactoryGirl.create(:todo)
    FactoryGirl.create(:todo)

    expect(Todo.completed.count).to eq 1
    expect(Todo.incompleted.count).to eq 2
    pp Todo.incompleted
    Todo.destroy_all

  end


  



  it "can tell the first day of a week" do 
    expect(Todo.first_day_of_week(45)).to eq Date.parse("3/11/2013")
  end


  it "can tell the last day of a week" do 
    expect(Todo.last_day_of_week(45)).to eq Date.parse("9/11/2013")
  end

  
  
  it "will display a due date for a daily task" do 
    daily_todo = FactoryGirl.build(:todo)
    expect(daily_todo.due_on).to eq Date.today
  end


it "will display a due date for a weekly task" do 
    
    weekly_todo = FactoryGirl.build(:todo, {:year => 2013, :month => 11, :week => 45, :day => nil})
    expect(weekly_todo.due_on).to eq Date.parse("9/11/2013")
    
  end


  it "will display a due date  for a monthly task" do 
    monthly_todo = FactoryGirl.build(:todo, {:day => nil, :week => nil, :month => 11, :year => 2013})
    expect(monthly_todo.due_on).to eq Date.parse("30/11/2013")

  end



  
  it 'generates monthly tasks' do  
  	totes = Todo.all.count
	wat = Todo.generate_monthly(@family.id, @task1.id, Date.today)
  	expect(Todo.all.count).to eq totes + 1
  end


  it 'generates weekly tasks' do  
  	totes = Todo.all.count
	wat = Todo.generate_weekly(@family.id, @task2.id, Date.today)
  	expect(Todo.all.count).to eq totes + 1
  end

  it 'generates daily tasks' do  
  	totes = Todo.all.count
	wat = Todo.generate_daily(@family.id, @task2.id, Date.today)
  	expect(Todo.all.count).to eq totes + 1
  end

end
