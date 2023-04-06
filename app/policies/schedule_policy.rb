class SchedulePolicy < ApplicationPolicy
    attr_reader :user, :schedule

    # initialization rules for schedules
    def initialize(user, schedule)
        @user = user
        @schedule = schedule
    end

    # check for admin permissions
    def admins?
        user.is_admin?
    end

    # check for staff permissions
    def staffs?
        user.is_staff?
    end

    # finds if user is admin or staff
    def admin_or_staff?
        user.is_admin || user.is_staff
    end

    # rule for new schedule
    def new?
        create?
    end

    # rule for creating schedule
    def create?
        admin_or_staff?
    end

    # rule for editing schedule
    def edit?
        update?
    end

    # rule for updating schedule
    def update?
        admin_or_staff?
    end

    # rule for schedule deletion
    def delete?
        destroy?
    end

    # rule for schedule destruction
    def destroy?
        admin_or_staff?
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
