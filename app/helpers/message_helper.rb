module MessageHelper
    def inbox_trips
        if current_user.present?
            user_trips        = current_user.trips.pluck(:id)
            user_ridden_trips = Rider.where(user: current_user).pluck(:trip_id)
            Trip.where(id: user_trips + user_ridden_trips).select {|trip| trip.messages.present? }
        end
    end
end