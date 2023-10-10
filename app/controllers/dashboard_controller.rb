class DashboardController < ApplicationController

  def home
    @total_cash_value       = Money.new(PolicyFinancial.latest.sum(:cash_value_cents)).format
    @net_cash_value         = Money.new(PolicyFinancial.latest.sum(:net_cash_value_cents)).format
    @total_outstanding_loan = Money.new(PolicyFinancial.latest.sum(:loan_balance_cents)).format
    @dividend_earned        = Money.new(PolicyFinancial.latest.sum(:dividend_earned_cents)).format
  end

end
