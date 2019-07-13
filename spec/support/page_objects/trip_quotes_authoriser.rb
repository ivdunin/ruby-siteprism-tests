# frozen_string_literal: true

module Pages
  class TripQuotesAuthoriser < TripQuotes
    # TODO: move to section to work with multiple quotes
    element :authorise_button, '.quotes-cont__btns-group .btn-primary', exact_text: 'AUTHORISE'

    element :banner_authorised, "div.alert.fade.in.alert-success", text: "Successfully authorised"

    def authorise_quote
      authorise_button.click
      wait_until_authorise_button_invisible

      return dashboard_page if skip_survey

      # we show banner only if no survey
      custom_wait_for_element { banner_authorised }
      close_banner
      dashboard_page
    end
  end
end