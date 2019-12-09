FactoryBot.define do
  factory :empty_service, class: Arkaan::Monitoring::Service do
    factory :service do
      key { 'elements' }
      path { '/elements' }
    end
  end
end