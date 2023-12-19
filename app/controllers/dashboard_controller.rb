class DashboardController < ApplicationController

  def home
    @total_cash_value       = Money.new(PolicyFinancial.latest.sum(:cash_value_cents)).format
    @net_cash_value         = Money.new(PolicyFinancial.latest.sum(:net_cash_value_cents)).format
    @total_outstanding_loan = Money.new(PolicyFinancial.latest.sum(:loan_balance_cents)).format
    @dividend_earned        = Money.new(PolicyFinancial.latest.sum(:dividend_earned_cents)).format
  end


  def detail
    @policy_numbers = Policy.pluck(:number)
    @years = PremiumPayment.order(:year).select(:year).distinct.pluck(:year)

    @pp = @years.each_with_object({}) do |y, o|
      pp_for_year = PremiumPayment.where(year: y)

      o[y] = Policy.all.each_with_object({}) do |p, o|
        o[p.number] = pp_for_year.where(policy: p).take&.amount
      end
    end
  end
end
