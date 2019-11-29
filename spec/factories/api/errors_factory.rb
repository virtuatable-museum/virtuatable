FactoryBot.define do
  factory :base_error, class: Virtuatable::API::Errors::Base do
    initialize_with {
      new(
        status: 500,
        field: 'concerned_field',
        error: 'returned_error'
      )
    }
  end
  factory :not_found_error, class: Virtuatable::API::Errors::NotFound do
    initialize_with {
      new(
        field: 'concerned_field',
        error: 'unknown'
      )
    }
  end
  factory :forbidden_error, class: Virtuatable::API::Errors::Forbidden do
    initialize_with {
      new(
        field: 'concerned_field',
        error: 'forbidden'
      )
    }
  end
  factory :bad_request_error, class: Virtuatable::API::Errors::BadRequest do
    initialize_with {
      new(
        field: 'concerned_field',
        error: 'required'
      )
    }
  end
end