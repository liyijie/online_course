class AddCodeToSpecialty < ActiveRecord::Migration
  def change
    add_column :specialties, :code, :string
  end
end
