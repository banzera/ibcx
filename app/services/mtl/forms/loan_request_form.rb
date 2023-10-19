module MTL
  module Forms
    class LoanRequestForm < MTLRequestForm
      include ActiveSupport::NumberHelper

      X = "X"

      def field_map
        ActiveSupport::HashWithIndifferentAccess.new({
          phone:                    ".P[0].Phone[0]",
          email:                    ".P[4].Email[0]",
          insured:                  ".Insured[0]",
          stipulated_loan_amount:   ".PayPremiumDue[0]",
          maximum_loan_amount:      ".MaximumLoanAmount[0]",
          pay_premium_on_policy:    ".PayPremiumDue[1]",
          deposit_to_account:       ".PayPremiumDue[2]",
          loan_amount:              ".LoanAmount[0]",
          account_ending_in:        ".PremiumDue[1]",
          premium_on_policy_number: ".DueonPolicyNo[0]",
          premium_due_on_date:      ".PremiumDue[0]",
          date_signed_owner1:       ".DateSigned[0]",
          date_signed_owner2:       ".DateSigned[1]",
          date_signed_poa:          ".P[14].DateSigned[0]",
          owner_name:               ".PolicyOwnerName[0]",
          policy_number:            ".PolicyNo[0]",
          # Unused / Unknown fields in document:
          # ".P[0]"
          # ".P[4]"
          # ".P[14]"
          # ".P[19]"
          # ".P[19].QRCodeBarcode1[0]"
          # ".TextField[0]"
          # ".PremiumDue[0]"
        })
      end


      def initialize
        super Rails.root / FORMS_PATH / "6106_policy_loan_request.pdf"
      end

      def maximum_loan!
        set_field mf(:maximum_loan_amount), X
      end

      def stipulate_loan_amount!(amt=0)
        set_field mf(:stipulated_loan_amount), X
        set_field mf(:loan_amount), number_to_delimited(amt)
      end

      def direct_premium_to!(policy_number: BLANK, due_date: nil)
        set_field mf(:pay_premium_on_policy), X
        set_field mf(:premium_on_policy_number), policy_number
        set_field mf(:premium_due_on_date), due_date.to_date.to_fs(:american) if due_date.present?
      end

      def deposit_to_account!(acct_last_4=BLANK)
        set_field mf(:deposit_to_account), X
        set_field mf(:account_ending_in), acct_last_4
      end
    end
  end
end
