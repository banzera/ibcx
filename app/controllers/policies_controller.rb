class PoliciesController < ApplicationController
  load_and_authorize_resource

  def index
    @policies = Policy.all
  end

  def show
    @page_title = @policy.number
    @tco = @policy.premium_payments.map(&:amount).sum
    @ccv = @policy.current_financials.take.cash_value
    @cv_to_capital = @ccv / @tco

  end

  def fetch
    svc = @policy.account.service_adapter
    svc[@policy.number].process

    redirect_to action: :show
  end

  def history
    @page_title = "Policy #{@policy.number} : History"

    f = @policy.financials

    @data = %i(cash_value net_cash_value ).map do |m|
      {name: m.to_s.titleize, data: f.map {|f| [f.created_at, f.send(m).to_s]}}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy
      @policy = Policy.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def policy_params
      params.fetch(:policy, {})
    end
end
