require 'date'

class Member < ActiveRecord::Base
  #extend FriendlyId
  #friendly_id :full_name, use: :slugged
  belongs_to :family
  belongs_to :member_type
  has_many :todos
  has_many :histories

  attr_accessible :birthdate, :email, :first_name, :last_name, :password, :family_id, :member_type_id, :required_points, :is_admin

  def admin?
    is_admin
  end

  def full_name
  	"#{first_name} #{last_name}"
  end

  def needed_points
    quota - current_points
  end

  def quota
    current_points('quota')
  end

  def current_stats 
    stats = {
      :quota => required_points,
      :current_points => current_points,
      :points_needed => (required_points - current_points),
      :tasks_completed => todos.completed.count,
      :tasks_incompleted => todos.incompleted.count
    }

    return stats
  end

  def current_points(type = 'current')
  	year = Date.today.year
  	week = Date.today.cweek
    
    if type == 'current'
    	current_todos = Todo.find_all_by_member_id_and_week_and_year_and_is_completed(id, week, year, true)
    else
      current_todos = Todo.find_all_by_member_id_and_week_and_year(id, week, year)
    end
  	
    #completed_todos.inject(0){ | result, todo | result}
  	result = 0
  	current_todos.each do | todo |
  		result += todo.task.points
  	end
  	return result
  end

  def points_for_week(week)

  end

end

