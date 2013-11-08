require 'date'

class Scheduler

  def initialize(family)
  	@ts_params = {}
  	t = Time.new
    @family = family
  	@ts_params[:y] = Date.today.year.to_i
  	@ts_params[:m] = Date.today.month.to_i
  	@ts_params[:w] = Date.today.cweek.to_i
  	@ts_params[:d] = Date.today.wday.to_i
  end



  def generate_todos(start_on)
  	@tasks = Task.active 
    @start_on = start_on

  	@tasks.each do | task | 
  		
      if task.interval.name == "Monthly"
  			generate_monthly_tasks(task)
	  	elsif task.interval.name == "Weekly"
	  		generate_weekly_tasks(task)
	  	elsif task.interval.name == "Daily"
        generate_daily_tasks(task)  		
	  	end

  	end

  end

  def get_first_day(now)
    
    today = @start_on
    diff = 0 + now.wday + 1
    now - diff.days

  end




  def generate_monthly_tasks(task)
    Todo.generate_monthly(@family.id, task.id, Date.today )
  end

  def generate_weekly_tasks(task)
    Todo.generate_weekly(@family.id, task.id, Date.today )
    Todo.generate_weekly(@family.id, task.id, Date.today + 7.days )
  end

  def generate_daily_tasks(task)
    first_day = get_first_day(Date.today)
    range = (0.upto 13)
    
    range.each do | d | 
      this_day = first_day + d.days
      Todo.generate_daily(@family.id, task.id, this_day)
    end
  end
  

  def ts_params
  	@ts_params
  end

  def family
    @family
  end
end