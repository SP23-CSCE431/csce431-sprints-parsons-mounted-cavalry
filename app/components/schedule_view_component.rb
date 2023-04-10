# frozen_string_literal: true

class ScheduleViewComponent < ViewComponent::Base
  # constructor - all starts with the given set of users
  def initialize(users, dates)
    super
    @dates = dates
    @users = users
  end

  # takes in a user and checks if they have a schedule
  # returns true is yes, false if no
  def user_has_schedule(user)
    Schedule.where(user_id: user.id).exists?
  end

  # takes in a user and a date, queries for an attendance that matches both
  # and returns the found attendance (if any)
  def get_user_attendance_by_date(user, date)
    schedule = Schedule.where(user_id: user.id).first
    return unless schedule

    attendance = Attendance.where(schedule_id: schedule.id, date: date).first

    attendance || nil
  end

  # takes in a user, finds the schedule associated
  # with the user (if any), and returns the recurrence of the schedule
  def get_user_schedule_recurrence(user)
    schedule = Schedule.where(user_id: user.id).first

    if schedule
      schedule.recurrence
    else
      ''
    end
  end

  # takes in a user, finds the schedule associated
  # with the user (if any), and returns the id of the schedule
  def get_user_schedule_id(user)
    schedule = Schedule.where(user_id: user.id).first

    schedule&.id
  end

  # maps the given user's skill level to a color, returns the color
  def get_user_skill_level_color(user)
    colors = { 'Beginner' => '#a7f1a8', 'Intermediate' => '#fff36d', 'Advanced' => '#f47174' }
    colors[user.skill_level]
  end

  # given a horse id, returns the horse
  def get_horse(horse_id)
    Horse.where(id: horse_id).first
  end

  # maps the given horse's difficulty level to a color, returns the color
  def get_horse_difficulty_color(horse)
    colors = { 'Easy' => '#a7f1a8', 'Intermediate' => '#fff36d', 'Advanced' => '#f47174' }

    if horse.nil?
      'none'
    else
      colors[horse.difficulty]
    end
  end

  # maps the given date's day name to the letter it is stored as in the database
  def get_day(date)
    days = { 'Monday' => 'M', 'Tuesday' => 'T', 'Wednesday' => 'W', 'Thursday' => 'R', 'Friday' => 'F' }
    day = Date.parse(date).strftime('%A')
    days[day]
  end
end
