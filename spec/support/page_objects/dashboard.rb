# frozen_string_literal: true

module Pages
  class Dashboard < BasePage
    # Class to describe base Dashboard page. Actions available for all users
    set_url "#{BASE_URL}"

    elements :workflow_buttons, "a.btn-workflow"
    element :icon_avatar, :xpath, "//span[starts-with(@class, 'avatar')]"
    element :a_logout, "a[href='/users/sign_out']"
    element :search_field, "input#search-control"
    element :company_info, "div.company-info"

    # Allow to click on workflow by it's name
    def select_workflow_by_name(name)
      workflow_buttons.each do |btn|
        if name.casecmp(btn.text) == 0
          btn.click
          break
        end
      end
      trip_details_page
    end

    def logout
      icon_avatar.click
      a_logout.click
      # Check that we are on a login page after logout
      login_page.btn_login
    end

    def search_trip_by_(uid_title_name)
      search_field.send_keys uid_title_name
      search_field.send_keys :enter
    end

    def company_name
      wait_until_company_info_visible
      company_info.text.match('^Company: (\w+)$').captures
    end

    def company_code
      wait_until_company_info_visible
      company_info.text.match('^Code: (\w+)$').captures
    end
  end
end