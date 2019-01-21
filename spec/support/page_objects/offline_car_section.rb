# frozen_string_literal: true

# TODO: move to separate folder (sections), create base class for segment section
module Pages
  class OfflineCarSection < SitePrism::Section
    element :loc_pickup, "div#travel_details_car_segments_attributes_0_from_location_chosen"
    element :loc_dropoff, "div#travel_details_car_segments_attributes_0_to_location_chosen"
    element :i_loc_pickup, "input.chosen-search-input[aria-label='Pick-up*']"
    element :i_loc_dropoff, "input.chosen-search-input[aria-label='Drop-off*']"
    element :date_pickup, "input#travel_details_car_segments_attributes_0_from_date"
    element :date_dropoff, "input#travel_details_car_segments_attributes_0_to_date"

    element :first_option, "li[data-option-array-index='1']"
    element :ta_request, "textarea#travel_details_car_segments_attributes_0_comments"

    # Scroll to element to make all block visible
    def make_visible
      ta_request.click
      wait_until_ta_request_visible
    end

    def fill_in_pickup_dropoff(pickup, dropoff)
      loc_pickup.click
      wait_until_i_loc_pickup_visible
      i_loc_pickup.send_keys pickup, :enter
      first_option.click

      loc_dropoff.click
      wait_until_i_loc_dropoff_visible
      i_loc_dropoff.send_keys dropoff, :enter
      first_option.click
    end

    def fill_in_pick_up_date(pickup_date)
      date_pickup.send_keys pickup_date, :enter
    end
  end
end

