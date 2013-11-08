require 'date'

class Todo < ActiveRecord::Base

  attr_accessible :day, :is_completed, :month, :week, :year, :date
  
  belongs_to :member
  belongs_to :task
  belongs_to :family

  default_scope { order(:date)}

  scope :completed, -> { where(is_completed: true)}
  scope :incompleted, -> {  where(is_completed: nil)}


  def assigned?
    if member.nil?
      false 
    else
      true
    end
  end

  def owned? (member_id)
    if member == nil
      false 
    elsif member.id == member_id
      true
    else
      false
    end
  end


  def completed?
    is_completed
  end

  def due_on_as_text
    #monthly
    unless day.nil?
     "Do it on this #{due_on.strftime('%A')} "
    #daily
    else
      "Do it by this #{due_on.strftime('%A')} "
    end

  end
  def due_today?
    if due_on == Date.today
      true
    else
      false
    end
  end
  
  def due_on
    #monthly
    if week.nil?
      Todo.last_sunday_of_month(month,year)
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
	t = Todo.find_or_create_by_family_id_and_task_id_and_year_and_month(family_id, task_id, today.year, today.month )
  #t.date = last_sunday_of_month(today.year, today.month)
  t.save
  end

  def self.generate_weekly(family_id, task_id, today)
	t = Todo.find_or_create_by_family_id_and_task_id_and_year_and_month_and_week(family_id, task_id, today.year, today.month, today.cweek )
  #t.date = Date.commercial(today.year, today.cweek) + 6.days
  t.save
  end

  def self.generate_daily(family_id, task_id, today)
	t = Todo.find_or_create_by_family_id_and_task_id_and_year_and_month_and_week_and_day(family_id, task_id, today.year, today.month, today.cweek, today.mday )
  #t.date = today
  t.save
  end


  #TODO: move this to a separate class
  def self.first_day_of_week(cweek)
    Date.commercial(Date.today.year, cweek, 1)
  end

  def self.last_day_of_week(cweek)
    Date.commercial(Date.today.year, cweek, 6) + 1.day
  end

  def self.last_sunday_of_month(month,year)
    first_day = Date.parse("1/#{month}/#{year}")
    
    last_day = first_day + 1.month - 1.day
    my_days = [0]
    result = (first_day..last_day).to_a.select {|k| my_days.include?(k.wday)}    
    puts "last day is #{result.last}"
    result.last
  end

end
