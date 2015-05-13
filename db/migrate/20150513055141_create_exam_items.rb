class CreateExamItems < ActiveRecord::Migration
  def change
    create_table :exam_items do |t|
      t.references :exam, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
