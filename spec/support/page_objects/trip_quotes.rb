# frozen_string_literal: true

module Pages
  class TripQuotes < BasePage
    set_url "#{BASE_URL}/workflows/{wid}/approvals/{aid}/quotes"

    element :state_pending_itinerary, "span[class$='state-pending_itinerary']"
    element :state_quote_issued, "span[class$='state-quote_issued']"
    element :state_pending_booking, "span[class$='state-pending_booking']"
    element :state_trip_booked, "span[class$='state-trip_booked']"

    elements :details_cell, "div.traveller-details__cell_value"
    element :btn_close_banner, "button.close"
    element :banner_success, "div.alert.fade.in.alert-success"

    def pending_itinerary?
      custom_wait_for_element { state_pending_itinerary }
      self
    end

    def quote_issued?
      custom_wait_for_element { state_quote_issued }
      self
    end

    def pending_booking?
      custom_wait_for_element { state_pending_booking }
      self
    end

    def trip_booked?
      custom_wait_for_element { state_trip_booked }
      self
    end

    # Get Approval UID from details panel (check all cells values and return one match regexp)
    def get_uid
      details_cell.each do |cell|
        cell.text if cell.text.match?(TMP_ID_REGEXP)
      end
    end

    def close_banner
      btn_close_banner.click
    end
  end
end