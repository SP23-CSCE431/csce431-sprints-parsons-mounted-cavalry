class UserPolicy < ApplicationPolicy
    attr_reader :user, :user

    def initialize(user, users)
        @user = user
        @users = users
    end

    def admin_or_staff?
        user.is_admin || user.is_staff
    end

    def new?
        create?
    end

    def create?
        admin_or_staff?
    end
    
    def edit?
        update?
    end

    def update?
        admin_or_staff?
    end

    def delete?
        destroy?
    end

    def destroy?
        admin_or_staff?
    end

    def admins?
        user.is_admin?
    end

    def staffs?
        user.is_staff?
    end
    def reports_admins?
        user.is_admin?
    end

    def reports_staffs?
        user.is_staff?
    end

    def checkin_cadets?
        !user.is_admin && !user.is_staff
    end
    
    def checkin_staffs?
        user.is_staff?
    end
    
    class Scope
        def initialize(user, scope)
            @user = user
            @scope = scope
        end

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
