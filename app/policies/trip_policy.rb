class TripPolicy < ApplicationPolicy
    class Scope
        attr_reader :user, :scope
    
        def initialize(user, scope)
          @user  = user
          @scope = scope
        end
    
        def resolve
            scope.all
        end
    end

    def edit?
        user.admin? || (record.user == user)
    end
    
    def update?
        edit?
    end

    def destroy?
        edit?
    end

    def new?
        true
    end

    def show?
        true
    end

    def create?
        true
    end
end