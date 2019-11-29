puts '> Configuration de RSpec'
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.profile_examples = 10

  puts '  +> Configuration des RSpec expectations'
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  puts '  +> Configuration des mocks RSpec'
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end