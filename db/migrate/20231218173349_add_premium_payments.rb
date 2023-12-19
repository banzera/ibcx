class AddPremiumPayments < ActiveRecord::Migration[7.0]
  def change

    create_table :premium_payments do |t|
      t.references :policy

      t.monetize :amount
      t.date     :paid_at
    end
  end
end
