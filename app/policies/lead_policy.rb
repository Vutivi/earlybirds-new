class LeadPolicy < ApplicationPolicy
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
        record.user || user.admin?
    end
    
    def update?
        edit?
    end

    def destroy?
        edit?
    end


    def for_single_trip?
       record.map {|lead| lead.trip.user }.all?(user)
    end

    def new?
        (user != record.trip.user)
    end

    def create?
        new?
    end

    def show?
        true
    end

    def index?
        user.admin?
    end
end