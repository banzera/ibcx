class LoanRequestFormTest < TLDR
  def loan_request_fill_data
    fill_data = {
      policy_number: '75462',
      insured:       'Julia Banz',
      phone:         '316-304-5125',
      owner_name:    'Bryan Banz',
      email:         'banzera@gmail.com',
      date_signed_owner1: Time.current.to_fs(:american),
    }
  end

  def setup
    @pdf = MTL::Forms::LoanRequestForm.new
    @pdf.fill_with(loan_request_fill_data)
  end

  def teardown
    @pdf.close
  end

  def test_stipulate_loan_request
    @pdf.stipulate_loan_amount!('10,000')
    @pdf.save_as('tmp/plr_stipulated.pdf')
  end

  def test_maximum_loan_request
    @pdf.maximum_loan!
    @pdf.save_as('tmp/plr_maximum.pdf')
  end

  def test_deposit_to_loan_request
    @pdf.deposit_to_account!('2553')
    @pdf.save_as('tmp/plr_dposit_to.pdf')
  end

  def test_direct_premium_loan_request
    @pdf.direct_premium_to!(policy_number: '717245', due_date: 1.month.from_now.to_fs(:american))
    @pdf.save_as('tmp/plr_direct_to.pdf')
  end
end
