class AddAccountToPolicies < ActiveRecord::Migration[7.0]
  def change
    change_table :policies do |t|
      t.references :account
    end
  end
end
