class FormsTest < TLDR

  def test_loan_repayment_request
    @pdf.save_as('tmp/filled.pdf')
  end

  def loan_request_fill_data
    fill_data = {
      policy_number:                 "4008746",
      owner_name:                    "Bryan Banz",
      amount:                        "500.00",
      deduction_begin_date:          "09/2023",
      day_of_month:                  "25th",
      signature_date:                "08/25/2023",
      financial_institution_name:    "Mid-Kansas Credit Union",
      financial_institution_addr:    "104 South Avenue B / Moundridge, KS / 67017",
      financial_institution_routing: "301179216",
      financial_institution_acct:    "000583010",
      insured_name:                  "Julia J Banz",
    }
  end

  def setup
    @pdf = MTL::Forms::LoanRepaymentRequestForm.new
    @pdf.fill_with(loan_request_fill_data)
  end

  def teardown
    @pdf.close
  end

end
