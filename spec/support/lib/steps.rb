# frozen_string_literal: true

def login_as(username, password)
  login_page.load
  login_page.login username, password
end

def logout
  dashboard_page.logout
end

def run_as(username, password, &block)
  # Login as user 'username' and execute all actions
  login_as username, password
  yield block
  logout
end

def select_workflow_by_name(workflow_name)
  dashboard_page.select_workflow_by_name workflow_name
end

def skip_survey
  SitePrism.logger.debug survey_page.current_url.to_s
  survey_page.skip_survey if survey_page.current_url.include? "surveys"
end

def open_quotes_page_by_ids(workflow_id, approval_id, as_role, uid = nil)
  # Open approval quotes page and verify that we open correct approval
  page = nil
  quotes_page.load(wid: workflow_id, aid: approval_id)
  expect(quotes_page.get_uid).equal? uid unless uid.nil?

  if as_role.casecmp(TMC) == 0
    page = quotes_page_tmc
  elsif as_role.casecmp(AUTHORISER) == 0
    page = quotes_page_authoriser
  elsif as_role.casecmp(TRAVELLER) == 0
    page = quotes_page
  else
    SitePrism.logger.error "Wrong role: #{as_role}!"
  end

  page
end

def search_trip_by_(search_text)
  dashboard_page.search_trip_by_ search_text
end

def with_trip_details_page
  yield trip_details_page
  trip_details_page.continue_booking
end

def with_trip_modules_page
  yield trip_modules_page
  trip_modules_page.submit_approval
end

def with_trip_details_review_page
  yield trip_details_review_page
end

def review_approval_after_creation
  trip_confirm_page.review_trip
end