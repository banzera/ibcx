class RepaymentRequestDocument

  attr_accessor :repayment_request

  def initialize(repayment_request = RepaymentRequest.new)
    @repayment_request = repayment_request
  end

  def render
    fn = -> (fn='') { "topmostSubform[0].Page1[0]" + fn }
    FillablePDF.new(Rails.root + 'lrr.pdf').tap do |pdf|
      pdf.set_field fn.call(".P[1].TextField2[0]"),    repayment_request.number # Policy Number
      pdf.set_field fn.call(".P[2].TextField2[0]"),    repayment_request.payor_name # Owner Name
      pdf.set_field fn.call(".P[3].NumericField1[0]"), repayment_request.amount
      pdf.set_field fn.call(".P[3].TextField2[0]"),    repayment_request.beginning.to_fs(:month_year)
      pdf.set_field fn.call(".P[4].TextField2[0]"),    repayment_request.dom.ordinalize
      pdf.set_field fn.call(".P[17].DateTimeField1[0]"), Time.current.to_date.to_fs(:american)  # sig date
      pdf.set_field fn.call(".TextField2[0]"),           "Mid-Kansas Credit Union"  # fin inst name
      pdf.set_field fn.call(".TextField2[1]"),           "104 South Avenue B / Moundridge, KS / 67017"  # fin inst addr
      pdf.set_field fn.call(".TextField2[2]"),           "301179216"  # fin inst routing
      pdf.set_field fn.call(".TextField2[3]"),           "000583010"  # fin inst acct
      pdf.set_field fn.call(".P[23].TextField2[0]"), repayment_request.primary_insureds_name # insured name

      Tempfile.create do |tf|
        pdf.save_as(tf.path)
        data = File.read(tf.path)
        @result = Base64.urlsafe_encode64(data)
      end
    end

    @result
  end

end
