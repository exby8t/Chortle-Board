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



  def generate_todos
  	@tasks = Task.all

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


  def generate_monthly_tasks(task)
    Todo.find_or_create_by_family_id_and_task_id_and_year_and_month(@family.id, task.id, @ts_params[:y], @ts_params[:m] )
  end

  def generate_weekly_tasks(task)
    Todo.find_or_create_by_family_id_and_task_id_and_year_and_month_and_week(@family.id, task.id, @ts_params[:y], @ts_params[:m],@ts_params[:w] )
  end

  def generate_daily_tasks(task)
    Todo.find_or_create_by_family_id_and_task_id_and_year_and_month_and_week_and_day(@family.id, task.id, @ts_params[:y], @ts_params[:m], @ts_params[:w], @ts_params[:d] )
  end
  def ts_params
  	@ts_params
  end

  def family
    @family
  end
end