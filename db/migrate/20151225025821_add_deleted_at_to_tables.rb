class AddDeletedAtToTables < ActiveRecord::Migration
  def change
    add_column(:courses, :deleted_at, :datetime)
    add_column(:sub_courses, :deleted_at, :datetime)
    add_column(:options, :deleted_at, :datetime)
    add_column(:questions, :deleted_at, :datetime)
  end
end
