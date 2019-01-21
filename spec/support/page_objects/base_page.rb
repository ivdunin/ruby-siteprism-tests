# frozen_string_literal: true

module Pages
  class BasePage < SitePrism::Page

    # wait for element for specified time
    def custom_wait_for_element(sec = WAIT_FOR_PRESENCE, &block)
      SitePrism.logger.debug"Set custom wait time to: #{sec}"

      Capybara.using_wait_time(sec) do
        yield
      end
    end

  end
end