FactoryBot.define do
  factory :empty_route, class: Arkaan::Monitoring::Route do
    factory :route do
      path { '/test' }
      verb { 'get' }
    end
  end
end