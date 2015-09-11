class CreatePaperOptions < ActiveRecord::Migration
  def change
    create_table :paper_options do |t|
      t.string :content
      t.string :index_type
      t.references :paper_question, index: true

      t.timestamps null: false
    end
  end
end
