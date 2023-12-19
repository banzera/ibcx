class PremiumPayment < ApplicationRecord
  include Olivander::Resources::AutoFormAttributes

  auto_resource_fields #columns: 4

  belongs_to :policy

  monetize :amount_cents, allow_nil: true

end
