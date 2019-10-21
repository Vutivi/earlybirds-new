module CategoryHelper
    def trips_for_category category_id
        events = Event.where(category_id: category_id).pluck(:id)
        Trip.where(event_id: events)
    end

    def trips_for_other_events category_id
        (Trip.events_trips - trips_for_category(category_id)).paginate(:page => params[:page], :per_page => 4)
    end
end