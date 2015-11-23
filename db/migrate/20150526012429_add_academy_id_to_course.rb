class AddAcademyIdToCourse < ActiveRecord::Migration
  def change
    add_reference :courses, :academy, index: true, foreign_key: true
  end
end
