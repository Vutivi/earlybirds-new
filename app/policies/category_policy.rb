class CategoryPolicy < ApplicationPolicy
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
        user.admin?
    end
    
    def update?
        edit?
    end

    def destroy?
        edit?
    end

    def new?
        edit?
    end

    def create?
        edit?
    end

    def show?
        true
    end

    def index?
        true
    end
end