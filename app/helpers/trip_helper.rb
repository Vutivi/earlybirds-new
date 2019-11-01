module TripHelper
    def set_rider_state trip
        rider_state = { 'true' => 'Leave', 'false' => 'Join'}
        rider       = Rider.where(trip: trip, user: current_user).present?
        rider_state[rider.to_s]
    end

    def social_share trip
        kind    = trip.kind.humanize
        time    = kind.eql?('daily work') ? '' : "on #{trip.departure_times.strftime("%d %B %Y, %H:%M ")}"
        content = "#{kind.capitalize} lift club from #{trip.start_location.split(',')[0]} to #{trip.end_location.split(',')[0]} available #{time}. Click #{root_url}#{trip_path(trip.slug)} for more information."

        social_share_button_tag(content, :url => trip_path(trip.slug), :image => url_for(trip.vehicle.image), desc: content)
    end

    def rider_id user, trip
        Rider.find_by(user: current_user, trip: trip)&.id
    end

    def is_full? trip
        trip.riders.size >= trip.seats
    end

    def search_results_count trips
        if params[:keyword].present?
            "(#{pluralize(trips.size, 'trip')} found)"
        end
    end

    def trip_time kind, time
        kind.eql?('daily_work') ? "#{time.strftime("%H:%M %p")} Weekdays" : time.strftime("%d %B %Y, %H:%M %p")
    end
end