# frozen_string_literal: true

module Pages
  class TripConfirm < BasePage
    set_url "#{BASE_URL}/workflows/{wid}/approvals/{aid}/successfully_submitted"

    element :btn_review, "a#review-trip"
    element :link_dashboard, "div.trip-successfully-submitted-link > a"

    def review_trip
      btn_review.click
      trip_details_review_page
    end

    def return_to_dashboard
      link_dashboard.click
      dashboard_page
    end
  end
end