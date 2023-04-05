class SchedulePolicy < ApplicationPolicy
    attr_reader :user, :schedule

    def initialize(user, schedule)
        @user = user
        @schedule = schedule
    end

    def admins?
        user.is_admin?
    end

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
