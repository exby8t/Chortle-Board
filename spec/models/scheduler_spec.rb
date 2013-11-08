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
  	
    Todo.destroy_all
    
    @scheduler.generate_todos(@today)
    
  	todos = Todo.all
  	
    #pp todos
    #create two weeks of todos
    #there should be 19 todos, 1 monthly, 4 weekly, and 14 daily
    expect(todos.count).to eq 19
  	
    #test daily todos
    d_task = Task.find_by_name('daily task')
    d_todo = Todo.find_by_task_id_and_day(d_task.id, @today.day)
    d_todos = Todo.find_all_by_task_id(d_task.id)

    expect(d_todo).to_not be_nil
    expect(d_todo.date).to_not be_nil
    expect(d_todos.count).to eq 14

    #test weekly todos
    w_task = Task.find_by_name('first weekly task')
    w_todo = Todo.find_by_task_id_and_week(w_task.id, @today.cweek)
    w_todos = Todo.find_all_by_task_id(w_task.id)

    expect(w_todo).to_not be_nil
    expect(w_todos.count).to eq 2    
    expect(w_todo.date).to_not be_nil
    expect(w_todo.date.wday).to eq 0

    #test monthly todos
    m_task = Task.find_by_name('monthly task')
    m_todo = Todo.find_by_task_id_and_month(m_task.id, @today.month)
    m_todos = Todo.find_all_by_task_id(m_task.id)

    expect(m_todo).to_not be_nil
    expect(m_todos.count).to eq 1
    expect(m_todo.date).to_not be_nil
    expect(m_todo.date.wday).to eq 0
  	#expect(todos[1].family.name).to eq "test fam"
    #expect(todos[1].week).to eq @today.cweek
    #expect(todos[1].day).to be_nil
    
    #expect(todos[5].day).to eq @today.wday
    #expect(todo[1].date).to_not be_nil
    #pp todos.last
    #expect(todos.last.day).to eq (today + 14.days).mday

    #pp Todo.all
    
    
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
