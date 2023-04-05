class SchedulePolicy < ApplicationPolicy
    attr_reader :user, :schedule

    #initialization rules for schedules
    def initialize(user, schedule)
        @user = user
        @schedule = schedule
    end

    #check for admin permissions
    def admins?
        user.is_admin?
    end

    #check for staff permissions
    def staffs?
        user.is_staff?
    end

    class Scope
        def initialize(user, scope)
        @user = user
        @scope = scope
        end

        def resolve
            if user.is_admin?
                scope.all
            else
                scope.where(user: user)
            end
        end

        private

        attr_reader :user, :scope
    end
end
