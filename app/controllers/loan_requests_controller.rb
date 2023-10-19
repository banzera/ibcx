class LoanRequestsController < ApplicationController
  before_action :set_policy

  def new
    @loan_request = LoanRequest.new(@policy)
    @loan_request.assign_attributes(loan_request_params)

    pdf = MTL::Forms::LoanRequestForm.new
    pdf.fill_with(form_data)
    pdf.stipulate_loan_amount! loan_request_params[:amount]

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
  end

  def loan_request_params
    params.fetch(:loan_request, {}).permit!
  end

  def form_data
    policy_data.merge(loan_request_params.except(:amount))
  end

  def policy_data
    {
      policy_number:      @policy.number,
      insured:            @policy.primary_insureds_name,
      owner_name:         @policy.payor_name,
      date_signed_owner1: Date.today.to_fs(:american),
    }
  end
end
