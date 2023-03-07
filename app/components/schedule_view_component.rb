# frozen_string_literal: true

class ScheduleViewComponent < ViewComponent::Base
  # constructor - all starts with the given set of users
  def initialize(users)
    @users = users
    @dates = ['2023-03-13', '2023-03-14', '2023-03-15', '2023-03-16', '2023-03-17']
  end

  # takes in a user and a date, queries for an attendance that matches both
  # and returns the found attendance (if any)
  def get_user_attendance_by_date(user, date)
    schedule = Schedule.where(:user_id => user.id).first
    unless schedule 
      return nil 
    end

    attendance = Attendance.where(:schedule_id => schedule.id, :date => date).first
    
    if attendance
      return attendance
    else
      return nil
    end
  end

  # takes in a user, finds the schedule associated
  # with the user (if any), and returns the recurrence of the schedule
  def get_user_schedule_recurrence(user)
    schedule = Schedule.where(:user_id => user.id).first
    
    if schedule
      return schedule.recurrence
    else
      return ''
    end
  end

  # takes in a user, finds the schedule associated
  # with the user (if any), and returns the id of the schedule
  def get_user_schedule_id(user)
    schedule = Schedule.where(:user_id => user.id).first
    
    if schedule
      return schedule.id
    else
      return nil
    end
  end

  # maps the given user's skill level to a color, returns the color
  def get_user_skill_level_color(user)
    colors = {'Beginner' => '#a7f1a8', 'Intermediate' => '#ffa756', 'Advanced' => '#f47174'}
    return colors[user.skill_level]
  end

  # given a horse id, returns the horse
  def get_horse(horse_id)
    horse = Horse.where(:id => horse_id).first
    
    return horse
  end

  # maps the given horse's difficulty level to a color, returns the color
  def get_horse_difficulty_color(horse)
    colors = {'Easy' => '#a7f1a8', 'Intermediate' => '#ffa756', 'Advanced' => '#f47174'}

    if horse == nil
      return 'none'
    else
      return colors[horse.difficulty]
    end
  end

  # maps the given date's day name to the letter it is stored as in the database
  def get_day(date)
    days = {'Monday' => 'M', 'Tuesday' => 'T', 'Wednesday' => 'W', 'Thursday' => 'R', 'Friday' => 'F'}
    day = Date.parse(date).strftime('%A')
    return days[day]
  end
end
