class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.references :question, foreign_key: true
      t.references :user, foreign_key: true
      t.references :audit_submission, foreign_key: true
      t.text :response_entry
      t.string :status

      t.timestamps
    end
  end
end
