class CreateAudits < ActiveRecord::Migration[5.2]
  def change
    create_table :audits do |t|
      t.string :title
      t.string :description
      t.string :department
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
