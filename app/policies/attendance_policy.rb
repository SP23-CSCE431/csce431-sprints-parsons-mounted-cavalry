class AttendancePolicy < ApplicationPolicy
    attr_reader :user, :attendance

    #initialization for rules related to attendance
    def initialize(user, attendance)
        @user = user
        @attendance = attendance
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

        #determines scope of permissions
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
