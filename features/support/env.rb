require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'selenium/webdriver'
require 'webdrivers/chromedriver'

Capybara.configure do |cfg|
  cfg.default_max_wait_time = 20
end

show_browser = ENV['SHOW_BROWSER'] == 'true'

### Driver config ###

if ENV['RUNNING_IN_DOCKER']
  selenium_hub_url = 'http://selenium-hub:4444/wd/hub'
  Capybara.register_driver :selenium_remote_firefox do |app|
    Capybara::Selenium::Driver.new(app, browser: :remote, url: selenium_hub_url, desired_capabilities: :firefox)
  end

  Capybara.javascript_driver = :selenium_remote_firefox
else
  if ENV['BROWSER'] == 'chrome'
    browser = :chrome
    options = ::Selenium::WebDriver::Chrome::Options.new
  else
    browser = :firefox
    options = ::Selenium::WebDriver::Firefox::Options.new
  end

  Capybara.register_driver :driver do |app|
    options.args << '--headless' unless show_browser
    Capybara::Selenium::Driver.new(app, browser: browser, options: options)
  end

  Capybara.javascript_driver = :driver
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

## default host to assist in rendering
Capybara.asset_host = 'http://localhost:3000'

## host directory for screenshot files
Capybara.save_path = 'testreport/'

# Keep only the screenshots generated from the last failing test suite
Capybara::Screenshot.prune_strategy = :keep_last_run
