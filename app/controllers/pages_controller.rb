class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home  
    # @social_trips         = Trip.where(kind: 'social_events')
    # @trips = Trip.where(kind: 'cross_province_home')
    # @daily_work_trips     = Trip.where(kind: 'daily_work').limit(8)
    # if the id params is present
    if params[:id]
      # get all records with id less than 'our last id'
      # and limit the results to 9
      @trips = Trip.where("kind = 2 AND id < ?", params[:id]).limit(9)
    else
      @trips = Trip.where(kind: 'cross_province_home').limit(9)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
end
