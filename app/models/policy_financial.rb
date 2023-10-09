class PolicyFinancial < ApplicationRecord
  include Olivander::Resources::AutoFormAttributes

  belongs_to :retrieval
  # belongs_to :policy, through: :retrieval

  def policy = retrieval.policy

  monetize :cash_value_cents,                      allow_nil: true
  monetize :loan_payoff_cents,                     allow_nil: true
  monetize :net_cash_value_cents,                  allow_nil: true
  monetize :cost_basis_cents,                      allow_nil: true
  monetize :dividend_earned_cents,                 allow_nil: true
  monetize :loan_balance_cents,                    allow_nil: true
  monetize :annual_premium_cents,                  allow_nil: true
  monetize :stipulated_annual_premium_cents,       allow_nil: true
  monetize :total_premiumn_collected_cents,        allow_nil: true
  monetize :maximum_annual_premium_limit_cents,    allow_nil: true
  monetize :minimum_annual_premium_required_cents, allow_nil: true

  def self.latest
    where(retrieval: Retrieval.latest.values)
  end
end
