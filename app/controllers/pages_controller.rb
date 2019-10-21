class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home  
    @social_trips         = Trip.where(kind: 'social_events')
    @cross_province_trips = Trip.where(kind: 'cross_province_home')
    @daily_work_trips     = Trip.where(kind: 'daily_work').limit(8)
  end
end
