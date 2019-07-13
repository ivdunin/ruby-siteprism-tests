# frozen_string_literal: true

# FIXME: remove require if possible
require 'spec_helper'


feature "E2E: Offline booking", feature: "regression test", regression_test: true do
  before do
    @traveller = Settings.users.traveller
    @tmc = Settings.users.tmc
    @authoriser = Settings.users.authoriser

    @workflow_name = "Offline - Cost Auth Only (Authoriser Group)"
    @approval_uid = nil
    @approval_id = nil
    @workflow_id = nil
  end

  scenario 'E2E: Offline - Cost Auth Only (Authoriser) -- flight', story: "offline booking", severity: :critical do
    run_as(@traveller.email, @traveller.password) do
      select_workflow_by_name(@workflow_name).loaded?

      with_trip_details_page do |p|
        departure_date = trip_date(days_ahead = 5)
        p.fill_in_trip_title "AT: #{@workflow_name}, departure on #{departure_date}"
        p.add_car_segment
        p.add_hotel_segment

        p.book_flight "MEL", "SYD", departure_date, "10:00 AM"
        p.book_hotel "Melbourne", trip_date(10)
        p.book_car "Sydney", "Melbourne", trip_date(10)

        p.select_auth_group_from_list "Demo_", "start_with"
        p.select_authoriser_from_list "#{@authoriser.last_name}, #{@authoriser.first_name}"
      end

      with_trip_modules_page do |p|
        p.select_cost_center "LCMDBT1-CCT4"
        p.select_declaration
      end

      skip_survey
      review_approval_after_creation

      with_trip_details_review_page do |p|
        @approval_uid = p.get_approval_uid
        @approval_id = p.get_approval_id
        @workflow_id = p.get_approval_workflow_id
      end
    end

    run_as(@tmc.email, @tmc.password) do
      open_quotes_page_by_ids(@workflow_id, @approval_id, TMC, @approval_uid)
        .pending_itinerary?
        .add_quote(100, trip_date(days_ahead = 2), 'XYZ123', "Quote comment: #{@approval_uid}")
        .submit_quotes
    end

    run_as(@authoriser.email, @authoriser.password) do
      open_quotes_page_by_ids(@workflow_id, @approval_id, AUTHORISER, @approval_uid)
        .quote_issued?
        .authorise_quote
    end

    run_as(@tmc.email, @tmc.password) do
      open_quotes_page_by_ids(@workflow_id, @approval_id, TMC, @approval_uid)
        .pending_booking?
        .mark_as_booked
    end

    run_as(@traveller.email, @traveller.password) do
      open_quotes_page_by_ids(@workflow_id, @approval_id, TRAVELLER, @approval_uid)
        .trip_booked?
    end
  end
end