# frozen_string_literal: true

class CadetReportsComponent < ViewComponent::Base
    def initialize(cadets, staffs)
        super @cadets = cadets
        super @staffs = staffs
    end
end
