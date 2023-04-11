class UserPolicy < ApplicationPolicy
    attr_reader :user, :users

    # initialization for rules related to user
    def initialize(user, users)
        @user = user
        @users = users
    end

    # finds if user is admin or staff
    def admin_or_staff?
        user.is_admin || user.is_staff
    end

    # rule for new user
    def new?
        create?
    end

    # rule for creating user
    def create?
        admin_or_staff?
    end

    # rule for editing user
    def edit?
        update?
    end

    # rule for updating user
    def update?
        admin_or_staff?
    end

    # rule for user deletion
    def delete?
        destroy?
    end

    # rule for user destruction
    def destroy?
        admin_or_staff?
    end

    # rule for admin page routing
    def admins?
        user.is_admin?
    end

    # rule for staff page routing
    def staffs?
        user.is_staff?
    end

    # rule for admin report routing
    def reports_admins?
        user.is_admin?
    end

    # rule for staff report routing
    def reports_staffs?
        user.is_staff?
    end

    # rule for cadet checkin routing
    def checkin_cadets?
        !user.is_admin && !user.is_staff
    end

    # rule for staff checkin routing
    def checkin_staffs?
        user.is_staff?
    end

    class Scope
        def initialize(user, scope)
            @user = user
            @scope = scope
        end

        # scope for permissions related to users
        def resolve
            if user.is_admin || user.is_staff?
                scope.all
            else
                scope.where(user: user)
            end
        end

        private

        attr_reader :user, :scope
    end
end
