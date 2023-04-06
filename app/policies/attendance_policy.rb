class AttendancePolicy < ApplicationPolicy
    attr_reader :user, :attendance

    # initialization for rules related to attendance
    def initialize(user, attendance)
        @user = user
        @attendance = attendance
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

    # rule for new atttendance
    def new?
        create?
    end

    # rule for creating atttendance
    def create?
        admin_or_staff?
    end

    # rule for editing atttendance
    def edit?
        update?
    end

    # rule for updating atttendance
    def update?
        admin_or_staff?
    end

    # rule for atttendance deletion
    def delete?
        destroy?
    end

    # rule for atttendance destruction
    def destroy?
        admin_or_staff?
    end

    class Scope
        def initialize(user, scope)
        @user = user
        @scope = scope
        end

        # determines scope of permissions
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
