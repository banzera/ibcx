class RepaymentRequestsController < ApplicationController
  before_action :set_policy

  def new
    @repayment_request = RepaymentRequest.new(@policy)
    @repayment_request.assign_attributes(repayment_request_params)

    pdf = MTL::Forms::LoanRepaymentRequestForm.new
    pdf.fill_with(form_data)

    Tempfile.create do |tf|
      pdf.save_as(tf.path)
      data = File.read(tf.path)
      @pdf = Base64.urlsafe_encode64(data)
    end

  end

  def create
    new and render :new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy
      @policy = Policy.find(params[:policy_id])

      if repayment_request_params[:financial_institution]
        @financial_institution = FinancialInstitution.find(repayment_request_params[:financial_institution])
      end
    end

    def repayment_request_params
      params.fetch(:repayment_request, {}).permit!
    end

    def form_data
      policy_data.merge(repayment_request_params.except(:financial_institution))
    end

    def policy_data
      {
        policy_number:                 @policy.number,
        owner_name:                    @policy.payor_name,
        signature_date:                Date.today.to_fs(:american),
        insured_name:                  @policy.primary_insureds_name,
        financial_institution_name:    @financial_institution&.name,
        financial_institution_addr:    @financial_institution&.addr,
        financial_institution_routing: @financial_institution&.routing,
        financial_institution_acct:    @financial_institution&.acct,
      }
    end
end
