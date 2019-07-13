# frozen_string_literal: true

def login_page
  @login_page ||= Pages::LoginPage.new
end

def dashboard_page
  @dashboard_page ||= Pages::Dashboard.new
end

def survey_page
  @survey_page ||= Pages::Survey.new
end

def quotes_page
  @quotes_page ||= Pages::TripQuotes.new
end

def quotes_page_tmc
  @quotes_page_tmc ||= Pages::TripQuotesTMC.new
end

def quotes_page_authoriser
  @quotes_page_authoriser ||= Pages::TripQuotesAuthoriser.new
end

def trip_details_page
  @trip_details ||= Pages::TripDetails.new
end

def trip_modules_page
  @trip_modules ||= Pages::TripModules.new
end

def trip_confirm_page
  @trip_confirm ||= Pages::TripConfirm.new
end

def trip_details_review_page
  @trip_details_review ||= Pages::TripDetailsReview.new
end