FactoryBot.define do
  factory :account, class: Arkaan::Account do
    factory :babausse do
      username { 'Babausse' }
      email { 'courtois.vincent@outlook.com' }
      firstname { 'Vincent' }
      lastname { 'Courtois' }
      password { 'password' }
      password_confirmation { 'password' }
    end
  end
end