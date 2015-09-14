class CreatePaperQuestions < ActiveRecord::Migration
  def change
    create_table :paper_questions do |t|
      t.references :paper, index: true
      t.string :title
      t.string :correct_answer
      t.integer :signal_score
      t.text :correct_hint
      t.integer :question_type

      t.timestamps null: false
    end
  end
end
