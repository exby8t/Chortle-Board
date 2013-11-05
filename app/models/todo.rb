require 'date'

class Todo < ActiveRecord::Base
  belongs_to :member
  belongs_to :task
  belongs_to :family
  attr_accessible :day, :is_completed, :month, :week, :year


  def self.generate_monthly(family_id, task_id, today)
	Todo.find_or_create_by_family_id_and_task_id_and_year_and_month(family_id, task_id, today.year, today.month )
  end

  def self.generate_weekly(family_id, task_id, today)
	Todo.find_or_create_by_family_id_and_task_id_and_year_and_month_and_week(family_id, task_id, today.year, today.month, today.cweek )
  end

  def self.generate_daily(family_id, task_id, today)
	Todo.find_or_create_by_family_id_and_task_id_and_year_and_month_and_week_and_day(family_id, task_id, today.year, today.month, today.cweek, today.mday )
  end

end
