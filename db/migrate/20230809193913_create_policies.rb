class CreatePolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :policies do |t|
      t.string  :number, nil: false
      t.string  :policy_type, nil: false
      t.string  :primary_insureds_name
      t.date    :dob
      t.integer :issue_age
      t.string  :payor_name
      t.string  :status
      t.date    :issue_date
      t.string  :base_plan
      t.string  :policy_class
      t.boolean :mec_status
      t.string  :dividend_option
      t.string  :nfo_option

      t.integer :sort_order

      t.timestamps
    end

    create_table :retrievals do |t|
      t.references :policy

      t.timestamps
    end

    create_table :policy_details do |t|
      t.references :retrieval

      t.string   :name
      t.monetize :face_amount
      t.monetize :annual_prem
      t.date     :maturity

      t.datetime :retrieved_at

      t.timestamps
    end

    create_table :policy_financials do |t|
      t.references :retrieval

      t.monetize :cash_value
      t.monetize :loan_payoff
      t.monetize :net_cash_value
      t.monetize :cost_basis
      t.monetize :dividend_earned
      t.date     :dividend_earned_at
      t.monetize :loan_balance
      t.string   :loan_interest_rate
      t.monetize :annual_premium
      t.date     :paid_to
      t.monetize :stipulated_annual_premium
      t.monetize :total_premiumn_collected
      t.date     :total_premiumn_collected_as_of
      t.monetize :maximum_annual_premium_limit
      t.monetize :minimum_annual_premium_required

      t.datetime :retrieved_at

      t.timestamps
    end
  end
end
