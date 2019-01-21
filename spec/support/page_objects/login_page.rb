# frozen_string_literal: true

module Pages
  class LoginPage < BasePage
    set_url "#{BASE_URL}" # TODO: move to env variables

    element :field_username, "#user_username"
    element :field_password, "#user_password"
    element :btn_login, '.btn-login'

    def login(username, password)
      field_username.set username
      field_password.set password
      btn_login.click
      wait_until_btn_login_invisible
    end
  end
end