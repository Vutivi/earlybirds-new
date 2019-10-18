class MessagePolicy < ApplicationPolicy
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

    def new?
        rider? || trip_owner?
    end

    def create?
        new?
    end

    def show?
        rider? || trip_owner? || user.admin?
    end

    def rider?
        record.trip.riders.map {|rider| rider.user }.include?(user)
    end

    def trip_owner?
        record.trip.user == user
    end

    def index?
        true
    end

end