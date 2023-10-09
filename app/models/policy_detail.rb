class PolicyDetail < ApplicationRecord
  include Olivander::Resources::AutoFormAttributes

  belongs_to :retrieval

  monetize :face_amount_cents, allow_nil: true
  monetize :annual_prem_cents, allow_nil: true
end
