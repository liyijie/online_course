class AddAnswerToExamItem < ActiveRecord::Migration
  def change
    add_column :exam_items, :answer, :string
    add_column :exam_items, :correct, :boolean
    add_column :exam_items, :item_index, :integer
    add_index :exam_items, :item_index
  end
end
