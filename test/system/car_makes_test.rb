require "application_system_test_case"

class CarMakesTest < ApplicationSystemTestCase
  setup do
    @car_make = car_makes(:one)
  end

  test "visiting the index" do
    visit car_makes_url
    assert_selector "h1", text: "Car Makes"
  end

  test "creating a Car make" do
    visit car_makes_url
    click_on "New Car Make"

    fill_in "Name", with: @car_make.name
    click_on "Create Car make"

    assert_text "Car make was successfully created"
    click_on "Back"
  end

  test "updating a Car make" do
    visit car_makes_url
    click_on "Edit", match: :first

    fill_in "Name", with: @car_make.name
    click_on "Update Car make"

    assert_text "Car make was successfully updated"
    click_on "Back"
  end

  test "destroying a Car make" do
    visit car_makes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Car make was successfully destroyed"
  end
end
