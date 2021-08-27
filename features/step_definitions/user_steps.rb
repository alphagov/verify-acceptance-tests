require 'yaml'
require 'uri'
require 'securerandom'

TEST_ENV = ENV.fetch('TEST_ENV', 'local')
ENVIRONMENTS = YAML.load_file(File.join(__dir__, 'environments.yml'))

def env(key)
  ENVIRONMENTS.dig(TEST_ENV, key)
end

def page_name_to_url_mapping(page_name)
  case page_name
  when 'Verify start'
    'start'
  when 'IDP sign-in'
    'sign-in'
  when 'prove identity'
    'prove-identity'
  end
end

def page_heading_text(page)
  case page
  when 'start'
    'Sign in with GOV.UK Verify'
  when 'sign-in'
    'Who do you have an identity account with?'
  when 'prove-identity'
    'Prove your identity to continue'
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

Given('we set the RP name to {string}') do |name|
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
  choose('start_form_selection_false', allow_label_click: true)
  click_on('Continue')
end

Given('this is their first time using Verify') do
  choose('start_form_selection_true', allow_label_click: true)
  click_on('Continue')
  click_link('Continue')
end

Given('they choose a registration journey') do
  choose('start_form_selection_true', allow_label_click: true)
  click_on('Continue')
  click_on('Continue')

  choose('will_it_work_for_me_form_above_age_threshold_true', allow_label_click: true)
  choose('will_it_work_for_me_form_resident_last_12_months_true', allow_label_click: true)
  click_on('Continue')
end

Given('they choose an loa1 registration journey') do
  choose('start_form_selection_true', allow_label_click: true)
  click_on('Continue')
  click_link('Continue')
end

And('they are above the age threshold') do
  choose('will_it_work_for_me_form_above_age_threshold_true', allow_label_click: true)
  choose('will_it_work_for_me_form_resident_last_12_months_true', allow_label_click: true)
  click_on('Continue')
end

And('they are below the age threshold') do
  choose('will_it_work_for_me_form_above_age_threshold_false', allow_label_click: true)
  choose('will_it_work_for_me_form_resident_last_12_months_true', allow_label_click: true)
  click_on('Continue')
end

When('they choose to use Verify') do
  click_on('Use GOV.UK Verify')
end

Given('they click {string}') do |string|
  click_on(string)
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

Given('they have all their documents') do
  check "A valid driving licence, full or provisional, with your photo on it", allow_label_click: true
  check "A valid passport", allow_label_click: true
end

Given('they do not have their documents') do
  uncheck "A valid driving licence, full or provisional, with your photo on it", allow_label_click: true
  uncheck "A valid passport", allow_label_click: true
  click_on('Continue')
end

Given('they do not have other identity documents') do
  choose('other_identity_documents_form_non_uk_id_document_false', allow_label_click: true)
  click_on('Continue')
end

Given('they have a smart phone') do
  choose('select_phone_form_mobile_phone_true', allow_label_click: true)
  choose('select_phone_form_smart_phone_true', allow_label_click: true)
  click_on('Continue')
end

Given('they do not have a phone') do
  uncheck "A phone or tablet that can download an app", allow_label_click: true
end

Given('they do have a phone') do
  check "A phone or tablet that can download an app", allow_label_click: true
end

Given('they continue to register with IDP {string}') do |idp|
  click_on("Choose #{idp}")
  @idp = "#{idp}"
end

Given('they continue with {string}') do |idp|
  click_on("Continue to the #{idp} website")
  @idp = "#{idp}"
end

Given('they click on continue') do
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

Given('they choose try to verify') do
  click_link('verify-identity-online')
end

Given('they select the link find another company to verify you') do
  click_link('Find another company to verify you')
end

Given('they choose to start again with another IDP') do
  click_on('startAgain')
end

Given('they go back to the {string} page') do |page_name|
  page_mapped_url = page_name_to_url_mapping(page_name)
  visit(URI.join(env('frontend'), page_mapped_url))

  page_text = page_heading_text(page_mapped_url)
  assert_text(page_text)
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

Given('they click continue on the confirmation page') do
  click_on('Continue')
end

Then('they should be at IDP {string}') do |idp|
  idp_url = env('idps').fetch(idp)
  page = URI.join(idp_url, 'login')
  assert_current_path(page.to_s, url: true)
end

Then('they should be successfully verified') do
  find('.success-notice')
  assert_text('Your identity has been confirmed')
end

Then('they should arrive at the {string} Cancel Registration page') do |idp|
  assert_text("You cancelled your identity verification with #{idp}")
end

Then('they should be successfully verified with level of assurance {string}') do |assurance_level|
  find('.success-notice')
  assert_text('Your identity has been confirmed')
  assert_text("level of assurance #{assurance_level}")
end

Then('a user should have been created with details:') do |details|
  assert_text('Your user account has been created')

  details.rows_hash.each do |k, v|
    assert_text("#{k}:#{v}")
  end
end

Then('they should arrive at the Test RP start page with error notice') do
  page = env('test-rp')
  assert_current_path(page, ignore_query: true)
  assert_text('Test GOV.UK Verify user journeys')
  assert_text('There has been a problem signing you in.')
end

Then('should arrive at the user account creation error page') do
  assert_text('Sorry, there is a problem with the service')
  assert_current_path('/response-processing')
end

Then('they should arrive at the Start page') do
  assert_text('Sign in with GOV.UK Verify')
end

Then('they arrive at the IDP sign-in page') do
  assert_text('Who do you have an identity account with?')
end

Then('they arrive at the confirm identity page for {string}') do |idp|
  assert_text('Sign in with ' + idp)
end

Then('they should arrive at the prove identity page') do
  assert_text('Prove your identity to continue')
  assert_text('Choose how you want to prove your identity so you can test GOV.UK Verify user journeys.')
  assert_current_path('/prove-identity')
end

Then('they arrive at the about page') do
  assert_text('GOV.UK Verify is a secure service built to fight the growing problem of online identity theft.')
end

Then('they should arrive at the Select documents page') do
  assert_text('Which of these do you have available right now?')
end

Then('they should arrive at the Sign in page') do
  assert_text('Who do you have an identity account with?')
end

Then('they should arrive at the Failed registration page') do
  assert_text("#{@idp} was unable to verify your identity")
end

Then('they should arrive at the Failed sign in page') do
  assert_text('You may have selected the wrong company')
end

Then('our Consent page should show "Level of assurance" = {string}') do |assurance_level|
  assert_text("You've successfully authenticated with #{@idp}")
  assert_text("#{assurance_level}")
end

When('they click button {string}') do |value|
  if @idp && value == ('Sign in with ' + @idp)
    page.find(:xpath, "//button[contains(text(), '#{value}')]").click
  else
    click_button(value)
  end
end

When('they click on link {string}') do |value|
  click_on(value)
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
  step('they have all their documents')
  step('they do have a phone')
  step('they click on continue')
  step("they continue to register with IDP '#{idp}'")
end

When('they visit the paused page') do
  visit(env('frontend') + "/paused")
end

Then('they will be at the Test RP start page') do
  assert_current_path(env('test-rp'))
end

When('frontend session times out') do
  page.driver.browser.manage.delete_cookie('_verify-frontend_session')
end

Given('the user is at the {string} prompt page') do |idp|
  idp_url = env('idps').fetch(idp)
  prompt_page = URI.join(idp_url, 'start-prompt')
  visit(prompt_page)
end

Given('they initiate single IDP journey with test-rp and IDP ID {string}') do |idpEntityId|
  fill_in('serviceId', with: env('test-rp-entity-id'))
  fill_in('idpEntityId', with: idpEntityId)
  click_on('Initiate Single IDP journey')
end

Then('they are sent to Test Rp') do
  assert_current_path('/test-rp')
end

Then('they land on the continue to idp page') do
  assert_current_path('/continue-to-your-idp')
end

Given('they continue to the idp') do
  click_on('continue-to-idp-button')
end

Then('they should see the disconnected IDP hint for {string}') do |idp|
  assert_text("This is tailored text for when #{idp} is disconnected")
end

And('they finish registering') do
  step('they give their consent')
  step('they click continue on the confirmation page')
  step('they should be successfully verified')
  click_on('Logout')
end
