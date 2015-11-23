class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :user_paper, index: true
      t.references :paper_question, index: true
      t.string :content
      t.integer :score
      t.boolean :correct

      t.timestamps null: false
    end
  end
end
