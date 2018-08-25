require "rails_helper"
require "capybara/rspec"
require "capybara/poltergeist"

Dir[Rails.root.join("spec", "features", "support", "**", "*.rb")].each { |f| require f }

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
                                    js_errors: false,
                                    timeout: 1000,
                                    phantomjs_options: [
                                      "--load-images=no",
                                      "--ignore-ssl-errors=yes",
                                      "--ssl-protocol=any"
                                    ])
end

Capybara.javascript_driver = :poltergeist

Capybara.default_wait_time = 15

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
