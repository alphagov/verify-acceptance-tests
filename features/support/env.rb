require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'selenium/webdriver'

Capybara.configure do |cfg|
  cfg.default_max_wait_time = 20
end

show_browser = ENV['SHOW_BROWSER'] == 'true'

no_javascript_driver = :no_javascript

no_javascript_options = ::Selenium::WebDriver::Firefox::Options.new
no_javascript_options.args << '--headless' unless show_browser
no_javascript_options.add_preference('javascript.enabled', false)

### Driver config ###

if ENV['TEST_ENV'] == 'local' || ENV['SHOW_BROWSER']
  Capybara.register_driver :firefox_headless do |app|
    options = ::Selenium::WebDriver::Firefox::Options.new
    options.args << '--headless'

    Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
  end

  Capybara.javascript_driver = :firefox_headless unless show_browser

  Capybara.register_driver :no_javascript do |app|
    Capybara::Selenium::Driver.new(app, browser: :firefox, options: no_javascript_options)
  end
else
  selenium_hub_url = 'http://selenium-hub:4444/wd/hub'
  Capybara.register_driver 'selenium_remote_firefox'.to_sym do |app|
    Capybara::Selenium::Driver.new(app, browser: :remote, url: selenium_hub_url, desired_capabilities: :firefox)
  end

  Capybara.javascript_driver = :selenium_remote_firefox

  Capybara.register_driver :no_javascript do |app|
    Capybara::Selenium::Driver.new(app, browser: :remote, url: selenium_hub_url, desired_capabilities: :firefox, options: no_javascript_options)
  end
end

Capybara.default_driver = Capybara.javascript_driver

### Screenshot config ###

## screenshots saved under test name + date
Capybara::Screenshot.register_filename_prefix_formatter(:cucumber) do |failing_test|
  "screenshot_#{failing_test.name.tr(' ', '-').gsub(%r{^.*\/spec\/}, '')}"
end

## dynamically register javascript screenshot driver
Capybara::Screenshot.register_driver(Capybara.javascript_driver) do |driver, path|
  driver.browser.save_screenshot(path)
end

## dynamically register no_javascript screenshot driver
Capybara::Screenshot.register_driver(no_javascript_driver) do |driver, path|
  driver.browser.save_screenshot(path)
end

## default host to assist in rendering
Capybara.asset_host = 'http://localhost:3000'

## host directory for screenshot files
Capybara.save_path = 'testreport/'

# Keep only the screenshots generated from the last failing test suite
Capybara::Screenshot.prune_strategy = :keep_last_run
