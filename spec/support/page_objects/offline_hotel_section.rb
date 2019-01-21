# frozen_string_literal: true

# TODO: move to separate folder (sections), create base class for segment section
module Pages
  class OfflineHotelSection < SitePrism::Section
    element :city, "div#travel_details_hotel_segments_attributes_0_from_location_chosen"
    element :i_city, "input.chosen-search-input[aria-label='City or town*']"

    element :i_check_in, "input#travel_details_hotel_segments_attributes_0_from_date"
    element :i_check_out, "input#travel_details_hotel_segments_attributes_0_to_date"

    element :first_option, "li[data-option-array-index='1']"
    element :ta_request, "textarea#travel_details_hotel_segments_attributes_0_comments"

    # Scroll to element to make all block visible
    def make_visible
      ta_request.click
      wait_until_ta_request_visible
    end

    def fill_in_city(city_name, change = true)
      current_sity = city.text
      SitePrism.logger.info "Current city value: #{current_sity}"
      city.click
      i_city.send_keys city_name
      if "Search...".casecmp(current_sity) != 0 && change
        second_option.click
      else
        first_option.click
      end
      wait_until_first_option_invisible
    end

    def fill_in_check_in_check_out(check_in)
      SitePrism.logger.info "Set hotel check-in to #{check_in}"
      i_check_in.send_keys check_in, :enter

      # TODO: add check out date
    end
  end
end
