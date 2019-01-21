# frozen_string_literal: true

module Pages
  class TripModules < BasePage
    set_url "#{BASE_URL}/workflows/{wid}/approvals/{aid}"

    element :btn_submit, "button[name=button]"

    # cost center module
    element :cost_center, "span#select2-cost_centre_allocations_cost_centre_allocations_attributes_0_cost_centre_id-container"
    element :in_cost_center, "input.select2-search__field"

    # declaration module
    element :in_declaration, "input#declaration_options_0"

    # business case module
    element :t_business_case, "textarea#business_case_description"

    # travel reason module
    element :travel_reason, "span#select2-travel_reason_travel_reason_id-container"
    elements :travel_reasons, "ul#select2-travel_reason_travel_reason_id-results > li"

    # TODO: move to base class (add select_by_text)
    def select_cost_center(cost_center_name)
      cost_center.click
      in_cost_center.send_keys cost_center_name, :enter
    end

    def select_declaration
      in_declaration.click
    end

    def submit_approval
      btn_submit.click
      wait_until_btn_submit_invisible
    end

    def fill_in_business_case(description = "Fake business case")
      t_business_case.send_keys description
    end

    def select_travel_reason(reason)
      travel_reason.click
      wait_until_travel_reasons_visible
      travel_reasons.each do |r|
        SitePrism.logger.debug "Check element: #{r.text}"
        if reason.casecmp(r.text) == 0
          r.click
          break
        end
      end
    end

  end
end