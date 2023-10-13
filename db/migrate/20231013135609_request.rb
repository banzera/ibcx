class Request < ActiveRecord::Migration[7.0]
  def change

    create_table :requests do |t|
      t.references :policy
      t.string :request_type
      t.jsonb :data
      t.attachment :document
    end

  end
end
