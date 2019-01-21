# frozen_string_literal: true

require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'config'
require 'require_all'


config_root = "#{File.dirname(__FILE__)}/../config"

Config.setup do |config|
  config.const_name = 'Settings'
  config.use_env = true
  config.fail_on_missing = true
  config.env_prefix = 'SETTINGS'
  config.env_separator = '__'
  config.env_converter = :downcase
  config.env_parse_values = true
end

Config.load_and_set_settings(Config.setting_files(config_root, ENV.fetch('TEST_ENV', 'local')))

# load all page objects, steps, constants
require_all 'spec/support'

class Capybara::Selenium::Driver
  private
    def delete_all_cookies
      @browser.manage.delete_all_cookies unless @browser.browser == :internet_explorer
    end
end

# local driver
def register_local_driver(*)
  Capybara.register_driver :selenium_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--window-size=#{Settings.browser.window_size}")

    Capybara::Selenium::Driver.new(
        app,
        browser: :chrome,
        options: options
    )
  end
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers

  config.before(:each) do |scenario|
    register_local_driver(scenario)

    Capybara.current_driver = :selenium_chrome # run using local selenium chrome driver by default
    SitePrism.enable_logging = SITEPRISM_DEBUG_MODE
  end

  config.around do |scenario|
    Capybara.using_wait_time(GLOBAL_WAIT_TIME) do
      scenario.run
    end
  end

  # SauceWhisk update the job status
  config.after(:each) do |scenario|
    Capybara.save_path = "results" if scenario.exception
  end
end
