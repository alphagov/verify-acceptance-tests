require 'yaml'
require 'uri'
require 'securerandom'

TEST_ENV = ENV.fetch('TEST_ENV', 'local')
ENVIRONMENTS = YAML.load_file(File.join(__dir__, 'environments.yml'))

def env(key)
  ENVIRONMENTS.dig(TEST_ENV, key)
end

def url_for_page(page_name)
  url =
    case page_name
    when 'Test RP'
      env('test-rp')
    when 'start'
      'start'
    when 'IDP sign-in picker'
      'sign-in'
    when 'user account creation error'
      'response-processing'
    end

  return unless url

  url.start_with?('http') ? url : "/#{url}"
end

def text_for_page(page)
  case page
  when 'start'
    'Sign in with GOV.UK Verify'
  when 'about'
    'GOV.UK Verify is a secure service built to fight the growing problem of online identity theft.'
  when 'user account creation error'
    'Sorry, there is a problem with the service'
  when 'about documents'
    'Before you start'
  when 'IDP registration picker'
    'Pick a certified company to verify you'
  when 'IDP sign-in picker'
    'Who do you have an identity account with?'
  when 'confirm identity'
    "Sign in with #{@idp}"
  when 'failed registration'
    "#{@idp} was unable to verify your identity"
  when 'failed sign-in'
    'You may have selected the wrong company'
  when 'cancelled registration'
    "You cancelled your identity verification with #{@idp}"
  when 'Test RP'
    'Test GOV.UK Verify user journeys'
  else
    raise ArgumentError("No text defined for page '#{page}'")
  end
end

def log_in_as(username)
  fill_in('username', with: username)
  fill_in('password', with: 'bar')
  click_on('SignIn')
  assert_text("You've successfully authenticated")
end

Before do  
  visit(env('frontend') + '/cookies')
  Capybara.reset_sessions!
end

Given('the user is at Test RP') do
  visit(env('test-rp'))
end

Given('the user is at {string}') do |url|
  visit(url)
end

Given('we do not want to match the user') do
  check('no-match')
end

Given('we want to fail account creation') do
  check('fail-account-creation')
end

Given('RP name is set to {string}') do |name|
  fill_in('rp-name', with: name)
end

Given('they select journey hint {string}') do |hint|
  select(hint, from: 'journey_hint')
end

Given('they start a journey') do
  click_on('Start')
end

Given('they start a sign in journey') do
  click_on('Start')
  click_on('Continue')
end

Given(/^they login as "(.*)"( with a random pid)?$/) do |user_string, with_random_pid|
  user_string = @username if user_string == 'the newly registered user'

  log_in_as(user_string)
  page.execute_script('document.getElementById("randomPid").value = "true"') if with_random_pid
  click_on('I Agree')
end

Given('they submit cycle 3 {string}') do |string|
  fill_in('cycle_three_attribute[cycle_three_data]', with: string)
  click_on('Continue')
end

Given('they continue to register with IDP {string}') do |idp|
  click_on("Choose #{idp}")
  @idp = "#{idp}"
end

Given('they click Continue') do
  click_on("Continue")
end

Then('they cannot continue to register with disconnected IDP {string}') do |idp|
  assert_no_text("Choose #{idp}")
end

Given('they register for an LOA1 profile with IDP {string}') do |idp|
  click_on("Choose #{idp}")
  @idp = "#{idp}"
end

Given('they select IDP {string}') do |idp|
  click_on("Select #{idp}", match: :prefer_exact)
end

Then('they cannot sign in with IDP {string}') do |idp|
  assert_no_text("Select #{idp}")
end

Given('the IDP returns an Authn Failure response') do
  click_on('tab-login')
  click_on('Authn Failure')
end

Given('the IDP returns a Requester Error response') do
  click_on('Submit Requester Error')
end

Given('they fail sign in with IDP') do
  click_on('Authn Failure')
end

Given('they choose to start again with another IDP') do
  click_on('startAgain')
end

When('they choose to try another company') do
  link = first('a', text: 'Pick another company.', count: nil)
  link ||= find('a', text: 'Try another certified company')
  link.click
end

Given /^they go back to the (.+) page$/ do |page_name|
  page_mapped_url = url_for_page(page_name)
  visit(URI.join(env('frontend'), page_mapped_url))

  assert_text(text_for_page(page_name))
end

Given('they want to cancel sign in') do
  click_on('Cancel')
end

Given('they want to cancel registration') do
  click_on('Cancel')
end

Given /they submit (loa1 |)user details:$/ do |assurance_level, details|
  details.rows_hash.each do |input, value|
    fill_in(input, with: value)

    if input == 'firstname'
      @username = value + SecureRandom.hex
    end
  end

  fill_in('username', with: @username)
  fill_in('password', with: 'bar')

  if assurance_level == 'loa1 '
    select('Level 1', from: 'loa')
  end
  click_on('Register')
end

Given('they give their consent') do
  click_on('I Agree')
end

Then('they should be at IDP {string}') do |idp|
  idp_url = env('idps').fetch(idp)
  page = URI.join(idp_url, 'login')
  assert_current_path(page.to_s, url: true)
end

Then('they should be successfully verified') do
  verify_success
end

Then('they should be successfully verified with level of assurance {string}') do |assurance_level|
  verify_success(assurance_level)
end

def verify_success(loa = nil)
  find('.success-notice')
  assert_text('Your identity has been confirmed')
  assert_text("level of assurance #{loa}") if loa
end

Then('a user should have been created with details:') do |details|
  assert_text('Your user account has been created')

  details.rows_hash.each do |k, v|
    assert_text("#{k}:#{v}")
  end
end

Then /^they should arrive at the (.+) page$/ do |page|
  assert_text(text_for_page(page))

  url = url_for_page(page)
  assert_current_path(url, ignore_query: true) if url
end

And('the Test RP page should have a sign-in error notice') do
  assert_text('There has been a problem signing you in.')
end

Then('the consent page should show level of assurance {string}') do |assurance_level|
  assert_text("You've successfully authenticated with #{@idp}")
  assert_text(assurance_level)
end

When('they click button {string}') do |value|
  if @idp && value == ('Sign in with ' + @idp)
    page.find(:xpath, "//button[contains(text(), '#{value}')]").click
  else
    click_button(value)
  end
end

When('they click on link {string}') do |value|
  click_link(value)
end

When('they choose to pause their journey') do
  click_on('Login')
  click_on('Save and Continue Later')
end

When('they continue verifying with {string}') do |idp|
  click_on("Continue verifying with #{idp}")
end

Given('they resume registering with IDP {string}') do |idp|
  click_on("Continue with #{idp}")
end

Then('they will be at the stateful paused page for {string}') do |idp|
  assert_current_path('/paused')
  assert_text("Your #{idp} identity account has been saved")
  page.assert_selector('a', id: 'next-button', text: "Continue verifying with #{idp}", visible: true)
end

Then('they will be at the resume page for {string}') do |idp|
  assert_current_path('/resume-registration')
  assert_text("Continue verifying with #{idp}")
  page.assert_selector('button', id: 'continue-to-idp-button', text: "Continue with #{idp}", visible: true)
end

Given('they start a registration journey with IDP {string}') do |idp|
  step('they start a journey')
  step('this is their first time using Verify')
  step('they are above the age threshold')
  step('they click Continue')
  step("they continue to register with IDP '#{idp}'")
end

When('they visit the paused page') do
  visit(env('frontend') + "/paused")
end

When('frontend session times out') do
  page.driver.browser.manage.delete_cookie('_verify-frontend_session')
end

Given('the user is at the IDP prompt page for {string}') do |idp|
  idp_url = env('idps').fetch(idp)
  prompt_page = URI.join(idp_url, 'start-prompt')
  visit(prompt_page)
end

Given('they initiate single IDP journey with Test RP and IDP ID {string}') do |idp_entity_id|
  fill_in('serviceId', with: env('test-rp-entity-id'))
  fill_in('idpEntityId', with: idp_entity_id)
  click_on('Initiate Single IDP journey')
end

Then('they should arrive at the Test RP') do
  step('they should arrive at the Test RP page')
end

Then('they land on the continue to IDP page') do
  assert_current_path('/continue-to-your-idp')
end

Given('they continue to the IDP') do
  click_on('continue-to-idp-button')
end

Then('they should see the disconnected IDP hint for {string}') do |idp|
  assert_text("This is tailored text for when #{idp} is disconnected")
end

And('they finish registering') do
  step('they give their consent')
  step('they click Continue')
  step('they should be successfully verified')
  click_on('Logout')
end
