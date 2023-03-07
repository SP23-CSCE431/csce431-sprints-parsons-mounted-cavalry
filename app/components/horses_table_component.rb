# frozen_string_literal: true

class HorsesTableComponent < ViewComponent::Base
  def initialize(horses)
    super
    @horses = horses
  end
end
