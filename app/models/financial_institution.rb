class FinancialInstitution < ApplicationRecord

  # belongs_to :tenant

  encrypts :routing
  encrypts :acct

end
