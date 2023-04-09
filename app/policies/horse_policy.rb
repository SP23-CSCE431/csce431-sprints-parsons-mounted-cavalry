class HorsePolicy < ApplicationPolicy
    attr_reader :user, :horse

    # initialization for rules related to horses
    def initialize(user, horse)
        @user = user
        @horse = horse
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

    # rule for new horse
    def new?
        create?
    end

    # rule for creating horse
    def create?
        admin_or_staff?
    end

    # rule for editing horse
    def edit?
        update?
    end

    # rule for updating horse
    def update?
        admin_or_staff?
    end

    # rule for horse deletion
    def delete?
        destroy?
    end

    # rule for horse destruction
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
