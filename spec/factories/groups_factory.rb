FactoryBot.define do
  factory :group, class: Arkaan::Permissions::Group do
    is_default { false }

    factory :users do
      slug { 'users' }
      is_superuser { false }
    end

    factory :administrators do
      slug { 'administrators' }
      is_superuser { true }
    end
  end
end