class AddFinancialInstitutions < ActiveRecord::Migration[7.0]
  def change
    create_table :financial_institutions do |t|
      t.references :tenant

      t.string :name, null: false
      t.string :addr, null: false
      t.string :routing, null: false
      t.string :acct, null: false

      t.timestamps
    end
  end
end
