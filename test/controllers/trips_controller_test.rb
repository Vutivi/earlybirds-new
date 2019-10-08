require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trip = trips(:one)
  end

  test "should get index" do
    get trips_url
    assert_response :success
  end

  test "should get new" do
    get new_trip_url
    assert_response :success
  end

  test "should create trip" do
    assert_difference('Trip.count') do
      post trips_url, params: { trip: { approved: @trip.approved, departure_times: @trip.departure_times, end_location: @trip.end_location, kind: @trip.kind, plan_id: @trip.plan_id, price: @trip.price, return_times: @trip.return_times, round_trip: @trip.round_trip, seats: @trip.seats, slug: @trip.slug, start_location: @trip.start_location, vehicle_id: @trip.vehicle_id } }
    end

    assert_redirected_to trip_url(Trip.last)
  end

  test "should show trip" do
    get trip_url(@trip)
    assert_response :success
  end

  test "should get edit" do
    get edit_trip_url(@trip)
    assert_response :success
  end

  test "should update trip" do
    patch trip_url(@trip), params: { trip: { approved: @trip.approved, departure_times: @trip.departure_times, end_location: @trip.end_location, kind: @trip.kind, plan_id: @trip.plan_id, price: @trip.price, return_times: @trip.return_times, round_trip: @trip.round_trip, seats: @trip.seats, slug: @trip.slug, start_location: @trip.start_location, vehicle_id: @trip.vehicle_id } }
    assert_redirected_to trip_url(@trip)
  end

  test "should destroy trip" do
    assert_difference('Trip.count', -1) do
      delete trip_url(@trip)
    end

    assert_redirected_to trips_url
  end
end
