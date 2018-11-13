class AddResultsToAuditSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :audit_submissions, :status_yes, :integer
    add_column :audit_submissions, :status_no, :integer
    add_column :audit_submissions, :status_na, :integer
  end
end
