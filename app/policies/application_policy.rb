class ApplicationPolicy
    attr_reader :user, :record

    #default initalization for policy rules
    def initialize(user, record)
        @user = User.where(:email => current_admin.email).first
        @record = record
    end

    #default index rule
    def index?
        false
    end

    #default show rule
    def show?
        false
    end

    #default create rule
    def create?
        false
    end

    #default new rule
    def new?
        create?
    end

    #default update rule
    def update?
        false
    end

    #default edit rule
    def edit?
        update?
    end

    #default destroy rule
    def destroy?
        false
    end

    class Scope
        def initialize(user, scope)
        @user = user
        @scope = scope
        end

        def resolve
        raise NotImplementedError, "You must define #resolve in #{self.class}"
        end

        private

        attr_reader :user, :scope
    end
    end
