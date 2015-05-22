class AddSexGradeIdSignatureToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :sex, :string
    add_reference :teachers, :grade, index: true, foreign_key: true
    add_column :teachers, :signature, :text
  end
end
