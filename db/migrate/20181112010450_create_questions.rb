class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :tooltip
      t.references :audit, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
