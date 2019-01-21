# frozen_string_literal: true

module Pages
  class TripDetails < BasePage
    set_url "#{BASE_URL}/workflows/{wid}/approvals/new"

    element :welcome_message, "div.welcome-message"
    element :field_trip_title, "input#approval_title"
    elements :btn_add_flight, "button.btn.btn-outline.add-flight"
    elements :btn_add_hotel, "button.btn.btn-outline.add-hotel"
    elements :btn_add_car, "button.btn.btn-outline.add-car"
    elements :btn_close_segments, "button.js-remove-booking-search-segment.booking-search__btn-remove"
    element :btn_continue, "button[name=button]"
    element :s2_auth_group, "span#select2-travel_details_authoriser_group_id-container"
    element :s2_authoriser, "span#select2-travel_details_authoriser_id-container"
    elements :auth_groups, "ul#select2-travel_details_authoriser_group_id-results > li"
    elements :authorisers, "ul#select2-travel_details_authoriser_id-results > li"
    element :no_results_found, "li#select2-results__option select2-results__message", exact_text: "No results found"

    sections :flight_block, OfflineFlightSection, "div.segment.flight"
    sections :hotel_block, OfflineHotelSection, "div.segment.hotel"
    sections :car_block, OfflineCarSection, "div.segment.car"

    load_validation { has_welcome_message? }

    def fill_in_trip_title(title)
      field_trip_title.send_keys title
    end

    def add_flight_segment
      btn_add_flight[0].click
    end

    def add_hotel_segment
      btn_add_hotel[0].click
    end

    def add_car_segment
      btn_add_car[0].click
    end

    def close_all_segments
      btn_close_segments.each(&:click)
      wait_until_btn_close_segments_invisible
    end

    def book_flight(location_from, location_to, date, time = "6:00 AM")
      # FIXME: now works only with first block
      flight = flight_block[0]
      flight.make_visible
      flight.fill_in_from_to location_from, location_to
      flight.fill_in_date_time date, time
    end

    def book_hotel(city, check_in, check_out = nil)
      hotel = hotel_block[0]
      hotel.make_visible
      hotel.fill_in_city city
      hotel.fill_in_check_in_check_out check_in
    end

    def book_car(pickup_location, dropoff_location, pickup_date)
      car = car_block[0]
      car.make_visible
      car.fill_in_pickup_dropoff pickup_location, dropoff_location
      car.fill_in_pick_up_date pickup_date
    end

    def select_auth_group_from_list(group, compare_method = 'exact')
      s2_auth_group.click
      wait_until_auth_groups_visible

      # TODO: move to base class, create method to work with select2
      auth_groups.each do |g|
        if compare(g.text, group, compare_method)
          g.click
          wait_until_auth_groups_invisible
          break
        end
      end
    end

    # TODO: move to base class (pass elements and text)
    def select_authoriser_from_list(authoriser, compare_method = 'exact')
      s2_authoriser.click
      wait_until_no_results_found_invisible

      authorisers.each do |a|
        if compare(a.text, authoriser, compare_method)
          a.click
          break
        end
      end
    end

    def continue_booking
      btn_continue.click
    end

    private

    def compare(text, pattern, method)
      SitePrism.logger.debug "Compare: '#{text}' with '#{pattern}', using #{method}"
      if method == 'exact'
        text.casecmp(pattern) == 0
      elsif method == 'start_with'
        text.start_with? pattern
      elsif method == 'end_with'
        text.end_with? pattern
      elsif method == 'include'
        text.include? pattern
      else
        raise "Wrong compare method: #{method}!"
      end
    end
  end
end