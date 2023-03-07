# frozen_string_literal: true

class UserTableComponent < ViewComponent::Base
  def initialize(user)
    super
    @user = user
  end
end
