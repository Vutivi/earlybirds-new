require "application_system_test_case"

class TripsTest < ApplicationSystemTestCase
  setup do
    @trip = trips(:one)
  end

  test "visiting the index" do
    visit trips_url
    assert_selector "h1", text: "Trips"
  end

  test "creating a Trip" do
    visit trips_url
    click_on "New Trip"

    check "Approved" if @trip.approved
    fill_in "Departure times", with: @trip.departure_times
    fill_in "End location", with: @trip.end_location
    fill_in "Kind", with: @trip.kind
    fill_in "Plan", with: @trip.plan_id
    fill_in "Price", with: @trip.price
    fill_in "Return times", with: @trip.return_times
    check "Round trip" if @trip.round_trip
    fill_in "Seats", with: @trip.seats
    fill_in "Slug", with: @trip.slug
    fill_in "Start location", with: @trip.start_location
    fill_in "Vehicle", with: @trip.vehicle_id
    click_on "Create Trip"

    assert_text "Trip was successfully created"
    click_on "Back"
  end

  test "updating a Trip" do
    visit trips_url
    click_on "Edit", match: :first

    check "Approved" if @trip.approved
    fill_in "Departure times", with: @trip.departure_times
    fill_in "End location", with: @trip.end_location
    fill_in "Kind", with: @trip.kind
    fill_in "Plan", with: @trip.plan_id
    fill_in "Price", with: @trip.price
    fill_in "Return times", with: @trip.return_times
    check "Round trip" if @trip.round_trip
    fill_in "Seats", with: @trip.seats
    fill_in "Slug", with: @trip.slug
    fill_in "Start location", with: @trip.start_location
    fill_in "Vehicle", with: @trip.vehicle_id
    click_on "Update Trip"

    assert_text "Trip was successfully updated"
    click_on "Back"
  end

  test "destroying a Trip" do
    visit trips_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trip was successfully destroyed"
  end
end
