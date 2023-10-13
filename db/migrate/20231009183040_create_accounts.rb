class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :provider
      t.string :username
      t.json :password

      t.timestamps
    end
  end
end
