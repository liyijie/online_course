class AddAppliedDateToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :applied_date, :string
  end
end
