module ApplicationHelper
    def visits_count visitable
        Ahoy::Event.where("properties ->> 'visitable_id' = '#{visitable.id}'", name: "View").size    
    end

    def current_user_is_owner? ownable
        current_user.eql?(ownable.user)
    end

    def set_user_profile_image user
        if user.profile_image.attached?
            url_for(user.profile_image)
        else
            "#{Rails.application.secrets.earlybirds_space_cdn_link}/default_profile_image.png"
        end
    end
end
