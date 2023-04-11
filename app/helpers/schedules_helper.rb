module SchedulesHelper
  # get the current user's role and return proper path for that role
  def schedules_get_user_path(user)
    if user.is_admin
      return admins_schedules_url
    elsif user.is_staff
      return staffs_schedules_url
    else
      return cadets_schedules_url
    end
  end

  # for every existing user, map the their full name to their id
  # return the pair for form dropdown purposes
  def users_full_name
    users = User.all
    u = {}
    users.each do |user|
      user_full_name = "#{user.first_name} #{user.last_name}"
      save_in_db = user.id
      u.store(user_full_name, save_in_db)
    end
    u
  end

  # takes a user id and returns their full name
  def user_full_name(user_id)
    user = User.find(user_id)

    user.first_name + ' ' + user.last_name
  end

  # maps a recurrence to a string of abbreviated days for better readability
  def recurrence_str(recurrence)
    days = { 'M' => 'Mon', 'T' => 'Tue', 'W' => 'Wed', 'R' => 'Thu', 'F' => 'Fri' }
    recur_str = ''

    recurrence.each do |c|
      recur_str += days[c] + ', '
    end

    recur_str.chop.chop
  end

  # given a day, get the range of dates of that day's week, and convert it to string
  def week_range(day)
    monday = day.at_beginning_of_week
    monday_month = monday.strftime('%B')

    friday = monday + 4
    friday_month = friday.strftime('%B')

    range_str = monday.strftime('%B %d') + ' - '
    if (monday_month != friday_month)
      range_str += friday.strftime('%B %d')
    else
      range_str += friday.strftime('%d')
    end

    range_str
  end

  # given a day, store that day's week dates in an array
  def week_dates(day)
    monday = day.at_beginning_of_week
    dates = [monday.strftime]

    next_day = monday

    # get Tuesday-Friday dates
    for i in 1..4
      next_day = next_day + 1
      dates.append(next_day.strftime)
    end

    dates
  end

  # map the abbreviated day string to the full name for the day
  def day_name(day)
    names = { 'M' => 'Monday', 'T' => 'Tuesday', 'W' => 'Wednesday', 'R' => 'Thursday', 'F' => 'Friday' }
    names[day]
  end
end
