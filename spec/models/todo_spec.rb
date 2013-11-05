require 'spec_helper'
require 'pp'
require 'date'

describe Todo do
  
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
