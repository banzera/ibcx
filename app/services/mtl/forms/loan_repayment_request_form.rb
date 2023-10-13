module MTL
  module Forms
    class LoanRepaymentRequestForm < MTLRequestForm
      def field_map
        {
          policy_number:                 ".P[1].TextField2[0]",
          owner_name:                    ".P[2].TextField2[0]",
          amount:                        ".P[3].NumericField1[0]",
          deduction_begin_date:          ".P[3].TextField2[0]",
          day_of_month:                  ".P[4].TextField2[0]",
          signature_date:                ".P[17].DateTimeField1[0]",
          financial_institution_name:    ".TextField2[0]",
          financial_institution_addr:    ".TextField2[1]",
          financial_institution_routing: ".TextField2[2]",
          financial_institution_acct:    ".TextField2[3]",
          insured_name:                  ".P[23].TextField2[0]",
        }
      end

      def initialize
        super Rails.root / FORMS_PATH / "1823_loan_repayment_request.pdf"
      end
    end
  end
end
