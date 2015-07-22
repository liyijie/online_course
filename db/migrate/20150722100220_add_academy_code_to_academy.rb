class AddAcademyCodeToAcademy < ActiveRecord::Migration
  def change
    add_column :academies, :academy_code, :string
  end
end
