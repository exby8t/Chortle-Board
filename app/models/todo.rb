require 'date'

class Todo < ActiveRecord::Base
  belongs_to :member
  belongs_to :task
  belongs_to :family
  attr_accessible :day, :is_completed, :month, :week, :year

  default_scope { order(:year, :month, :week, :day)}
  def assigned?
    if member.nil?
      false 
    else
      true
    end
  end

  def due_on
    #monthly
    if week.nil?
      Date.parse("30/#{month}/#{year}")
    #weekly
    elsif day.nil?
      Date.parse("#{Todo.last_day_of_week(week)}/#{month}/#{year}")
    #daily
    else
      Date.parse("#{day}/#{month}/#{year}")
    end

  end


  # CLASS METHODS

  def self.generate_monthly(family_id, task_id, today)
	Todo.find_or_create_by_family_id_and_task_id_and_year_and_month(family_id, task_id, today.year, today.month )
  end

  def self.generate_weekly(family_id, task_id, today)
	Todo.find_or_create_by_family_id_and_task_id_and_year_and_month_and_week(family_id, task_id, today.year, today.month, today.cweek )
  end

  def self.generate_daily(family_id, task_id, today)
	Todo.find_or_create_by_family_id_and_task_id_and_year_and_month_and_week_and_day(family_id, task_id, today.year, today.month, today.cweek, today.mday )
  end
  #TODO: move this to a separate class
  def self.first_day_of_week(cweek)
    Date.commercial(Date.today.year, cweek, 1) - 1.day
  end

  def self.last_day_of_week(cweek)
    Date.commercial(Date.today.year, cweek, 6)
  end



end
