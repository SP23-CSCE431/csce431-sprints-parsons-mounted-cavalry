# frozen_string_literal: true

class ReportsComponent < ViewComponent::Base
    def initialize(horses, cadets, staffs)
        super @horses = horses
        super @cadets = cadets
        super @staffs = staffs
    end
end
