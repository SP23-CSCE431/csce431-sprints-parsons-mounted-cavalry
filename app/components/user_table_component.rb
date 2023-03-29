# frozen_string_literal: true

class UserTableComponent < ViewComponent::Base
  def initialize(cadets, staffs)
      super @cadets = cadets
      super @staffs = staffs
  end

  # maps the given user's skill level to a color, returns the color
  def get_user_skill_color(user)
    colors = { 'Beginner' => '#A7F1A8', 'Intermediate' => '#FFF36D', 'Advanced' => '#F47174' }

    if user.nil?
        'none'
    else
        colors[user.skill_level]
    end
  end

  # maps the given user's permission level to a color, returns the color
  def get_user_permission_color(user)
    colors = { 'Admin' => '#A7F1A8', 'Staff' => '#F47174'}
  
    if user.nil?
      'none'
    else
      if user.is_admin
        colors['Admin']
      elsif user.is_staff
        colors['Staff']
      else
        'none'
      end
    end
  end  
end
