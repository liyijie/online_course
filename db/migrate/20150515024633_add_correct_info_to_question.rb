class AddCorrectInfoToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :correct_option, :string
    add_column :questions, :correct_hint, :string
  end
end
