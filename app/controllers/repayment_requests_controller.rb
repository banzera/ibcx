class RepaymentRequestsController < ApplicationController
  before_action :set_policy

  def new
    @repayment_request = RepaymentRequest.new(@policy)

    @pdf = RepaymentRequestDocument.new(@repayment_request).render
  end

  def create
    @repayment_request = RepaymentRequest.new(@policy)
    @repayment_request.assign_attributes(repayment_request_params)

    @pdf = RepaymentRequestDocument.new(@repayment_request).render

    render :new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy
      @policy = Policy.find(params[:policy_id])
    end

    def repayment_request_params
      params.require(:repayment_request).permit!
    end
end
