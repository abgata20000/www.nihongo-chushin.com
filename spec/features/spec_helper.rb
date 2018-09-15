require "rails_helper"
require "capybara/rspec"

Dir[Rails.root.join("spec", "features", "support", "**", "*.rb")].each { |f| require f }

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chrome_options: {
        args: %w[headless disable-gpu window-size=1920,1200 no-sandbox]
      }
    )
  )
end
Capybara.javascript_driver = :chrome

Capybara.default_max_wait_time = 15

shared_context "seed_data" do
  before(:all) do
    setup_seed_data
  end
  after(:all) do
    cleanup_seed_data
  end
end

RSpec.configure do |config|
  # config.use_transactional_fixtures = false
  config.verbose_retry = true
  config.display_try_failure_messages = true

  config.include SessionTestHelpers, type: :feature
  config.include AjaxTestHelpers, type: :feature
  config.include Capybara::DSL
end
