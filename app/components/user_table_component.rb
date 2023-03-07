# frozen_string_literal: true

class UserTableComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end

end
