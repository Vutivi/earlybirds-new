module ApplicationHelper
    def visits_count visitable
        Ahoy::Event.where("properties ->> 'visitable_id' = '#{visitable.id}'", name: "View").size    
    end

    def current_user_is_owner? ownable
        current_user.eql?(ownable.user) || current_user&.admin?
    end

    def set_user_profile_image user
        if user.profile_image.attached?
            url_for(user.profile_image)
        else
            "default_profile_image.jpg"
        end
    end

    def trips_joined_by_user
        user_ridden_trips = Rider.where(user: current_user).pluck(:trip_id)
        Trip.where(id: user_ridden_trips)
    end

    def trips_owned_by_user
        user_trips = current_user.trips.pluck(:id)
        Trip.where(id: user_trips)
    end

    def resource_name
        :user
    end
    
    def resource
        User.new
    end

    def devise_mapping
        Devise.mappings[:user]
    end
end
