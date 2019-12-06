module Enhancers
  class Account < Virtuatable::Enhancers::Base
    enhances Arkaan::Account

    def lastname
      "Sir #{object.lastname}"
    end
  end
end