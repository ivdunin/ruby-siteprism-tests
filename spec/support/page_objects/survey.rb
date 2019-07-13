# frozen_string_literal: true

module Pages
  class Survey < BasePage
    set_url "#{BASE_URL}/approvals/surveyable/{sid}/surveys/new"

    element :btn_div, "div.skip-approval-survey.text-center > a"
    element :btn_skip_survey, "a#skip_approval_survey"
    load_validation { has_btn_skip_survey? }

    def skip_survey
      btn_div.click
      wait_until_btn_div_invisible

      true # if click on skip survey
    end
  end
end