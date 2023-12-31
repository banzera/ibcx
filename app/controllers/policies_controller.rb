class PoliciesController < ApplicationController
  before_action :set_policy, only: %i[ show fetch history]

  def index
    @policies = Policy.all
  end

  def show
    @page_title = @policy.number
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
