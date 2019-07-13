# frozen_string_literal: true

module Pages
  class TripDetailsReview < BasePage
    set_url "#{BASE_URL}/workflows/{wid}/approvals/{aid}/review"
    element :trip_id, :xpath, '//div[starts-with(@class, "trip-id")]'

    def get_approval_uid
      trip_id.text.gsub('Trip ID: ', '')
    end

    def get_approval_id
      current_url.match(URL_REGEXP).captures[1]
    end

    def get_approval_workflow_id
      current_url.match(URL_REGEXP).captures[0]
    end

  end
end