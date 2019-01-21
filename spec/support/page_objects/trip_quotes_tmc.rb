module Pages
  class TripQuotesTMC < TripQuotes
    sections :quote_block, QuoteSection, "div.quotes-list > div.quote"

    # TODO: find better solution to support translation (not using text)
    element :btn_submit_quote, :xpath, "//button[@name='submitBtn']/span[contains(text(),'Submit 1 Quote')]"
    element :btn_submit_for_auth, :xpath, "//button[@name='submitBtn']/span[contains(text(),'Submit for Authorisation')]"
    element :i_marked_as_booked, "input[class$='mark-as-booked']"

    element :banner_itinerary_uploaded, "div.alert.fade.in.alert-success", text: "Itinerary Uploaded"
    element :banner_submitted, "div.alert.fade.in.alert-success", text: "has been submitted for approval!"
    element :banner_been_booked, "div.alert.fade.in.alert-success", text: "has been booked!"


    def add_quote(cost, auth_date, pnr = nil, comment = nil)
      # FIXME: work only with first quote
      quote = quote_block[0]
      quote.fill_in_cost cost
      quote.fill_in_auth_datetime auth_date, nil  # FIXME: set only date now

      quote.fill_in_pnr pnr unless pnr.nil?
      quote.fill_in_comment comment unless comment.nil?

      btn_submit_quote.click
      custom_wait_for_element { banner_itinerary_uploaded }
      self
    end

    def submit_quotes
      btn_submit_for_auth.click
      custom_wait_for_element { banner_submitted }
      dashboard_page
    end

    def mark_as_booked
      i_marked_as_booked.click
      custom_wait_for_element { banner_been_booked }
    end
  end
end