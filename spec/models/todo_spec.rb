require 'spec_helper'
require 'pp'
require 'date'

describe Todo do

  it "is assigned if a member is attached" do 
    todo = FactoryGirl.build(:todo)
    expect(todo.assigned?).to eq false
  end

  it "knows if it's in the past or not" do 
    past_todo = FactoryGirl.build(:todo, {date: Date.today - 1.day})
    now_todo = FactoryGirl.build(:todo, {date: Date.today})
    future_todo = FactoryGirl.build(:todo, {date: Date.today + 1.day})

    expect(past_todo.past?).to eq true
    expect(now_todo.past?).to eq false
    expect(future_todo.past?).to eq false

  end


  it "is NOT assigned if a member is NOT attached" do 
    member = FactoryGirl.create(:member)
    todo = FactoryGirl.build(:todo, {:member_id => member.id})
    expect(todo.assigned?).to eq true
    member.destroy
  end

  it "has a class method that determines the last sunday of the month" do 
      expect(Todo.last_day_of_week(45)).to eq Date.parse("10/11/2013")

  end

  it "is due on Sunday if it's a monthly or weekly task" do
    todo_m = FactoryGirl.build(:todo, {week: nil, day:nil} )
    todo_w = FactoryGirl.build(:todo, { day:nil} )
    expect(todo_m.due_on.wday).to eq 0
    expect(todo_w.due_on.wday).to eq 0


  end

  it "has a completed and incompleted scope" do 

    FactoryGirl.create(:todo, {:is_completed => true})
    FactoryGirl.create(:todo, {:is_completed => nil})
    FactoryGirl.create(:todo, {:is_completed => nil})

    

    expect(Todo.completed.count).to eq 1
    expect(Todo.incompleted.count).to eq 2
    pp Todo.incompleted
    Todo.destroy_all

  end
  
  
  it "will display a due date for a daily task" do 
    daily_todo = FactoryGirl.build(:todo)
    expect(daily_todo.due_on).to eq Date.today
  end


it "will display a due date for a weekly task on sunday" do 
    
    weekly_todo = FactoryGirl.build(:todo, {:year => 2013, :month => 11, :week => 45, :day => nil})
    expect(weekly_todo.due_on).to eq Date.parse("10/11/2013")
    
  end


  it "will display a due date  for a monthly task" do 
    monthly_todo = FactoryGirl.build(:todo, {:day => nil, :week => nil, :month => 11, :year => 2013})
    expect(monthly_todo.due_on).to eq Date.parse("24/11/2013")

  end



# CLASS METHODS!!!!


  it "can tell the first day of a week is a monday" do 
    expect(Todo.first_day_of_week(45)).to eq Date.parse("4/11/2013")
  end


  it "can tell the last day of a week is a sunday" do 
    expect(Todo.last_day_of_week(45)).to eq Date.parse("10/11/2013")
  end

  it "has a class method that determines the last sunday of the month" do 
      expect(Todo.last_sunday_of_month(11, 2013)).to eq Date.parse("24/11/2013")

  end

  it 'generates monthly tasks' do  
  	totes = Todo.all.count
	wat = Todo.generate_monthly(@family.id, @weekly_task1.id, Date.today)
  	expect(Todo.all.count).to eq totes + 1
  end


  it 'generates weekly tasks' do  
  	totes = Todo.all.count
	  wat = Todo.generate_weekly(@family.id, @weekly_task2.id, Date.today)
  	expect(Todo.all.count).to eq totes + 1
  end

  it 'generates daily tasks' do  
  	totes = Todo.all.count
	wat = Todo.generate_daily(@family.id, @weekly_task2.id, Date.today)
  	expect(Todo.all.count).to eq totes + 1
  end

end
