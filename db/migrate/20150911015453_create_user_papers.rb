class CreateUserPapers < ActiveRecord::Migration
  def change
    create_table :user_papers do |t|
      t.references :user, index: true
      t.references :paper, index: true
      t.boolean :answered, default: false
      t.integer :total_score

      t.timestamps null: false
    end
  end
end
