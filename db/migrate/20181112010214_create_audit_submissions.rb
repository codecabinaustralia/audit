class CreateAuditSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :audit_submissions do |t|
      t.references :audit, foreign_key: true
      t.boolean :completed
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
