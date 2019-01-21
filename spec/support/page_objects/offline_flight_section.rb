# frozen_string_literal: true

# TODO: move to separate folder (sections), create base class for segment section
module Pages
  class OfflineFlightSection < SitePrism::Section
    # location
    element :from, "div.control-group.form-group.airport_suggest.required.travel_details_flight_segments_from_location"
    element :in_from, "input.chosen-search-input[aria-label='From*']"
    element :to, "div.control-group.form-group.airport_suggest.required.travel_details_flight_segments_to_location"
    element :in_to, "input.chosen-search-input[aria-label='To*']"
    element :first_option, "li[data-option-array-index='1']"

    # date and time
    element :f_date, "input#travel_details_flight_segments_attributes_0_from_date"
    element :f_time, "input#travel_details_flight_segments_attributes_0_from_time"

    element :ta_request, "textarea#travel_details_flight_segments_attributes_0_comments"

    # Scroll to element to make all block visible
    def make_visible
      ta_request.click
      wait_until_ta_request_visible
    end

    def fill_in_from_to(location_from, location_to)
      from.click
      in_from.send_keys location_from
      first_option.click # FIXME: always select first element

      to.click
      in_to.send_keys location_to
      first_option.click
    end

    def fill_in_date_time(date, time)
      f_date.send_keys date, :enter
      f_time.native.clear
      f_time.send_keys time, :enter
    end
  end
end