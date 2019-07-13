# frozen_string_literal: true

# TODO: move to separate folder (sections)
module Pages
  class QuoteSection < SitePrism::Section
    element :i_cost, "input#itinerary_quotes_attributes__total_cost"
    element :i_auth_date, "input#itinerary_quotes_attributes__time_to_authorise"
    element :i_auth_time, "input#itinerary_quotes_attributes__time_to_authorise_time"
    element :i_pnr, "input#itinerary_quotes_attributes__pnr"
    element :i_comments, "textarea#itinerary_quotes_attributes__comments"

    def fill_in_cost(cost)
      i_cost.native.clear
      i_cost.send_keys cost
    end

    def fill_in_auth_datetime(date, time = nil)
      i_auth_date.send_keys date
      i_auth_time.send_keys time unless time.nil?
    end

    def fill_in_pnr(pnr)
      i_pnr.send_keys pnr
    end

    def fill_in_comment(comment)
      i_comments.send_keys comment
    end
  end
end

