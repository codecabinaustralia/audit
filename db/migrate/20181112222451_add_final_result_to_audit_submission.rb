class AddFinalResultToAuditSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :audit_submissions, :final_result, :decimal
  end
end
