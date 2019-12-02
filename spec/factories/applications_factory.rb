FactoryBot.define do
  factory :empty_application, class: Arkaan::OAuth::Application do
    factory :application do
      name { 'application' }
      key { 'application_key' }
      premium { false }

      factory :premium_app do
        key { 'premium_key' }
        premium { true }
      end
    end
  end
end