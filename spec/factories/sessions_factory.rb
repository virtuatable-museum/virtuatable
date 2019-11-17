FactoryBot.define do
  factory :session, class: Arkaan::Authentication::Session do
    token { 'session_token' }
  end
end