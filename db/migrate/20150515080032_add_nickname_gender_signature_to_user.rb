class AddNicknameGenderSignatureToUser < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :gender, :boolean, default: true
    add_column :users, :signature, :text
  end
end
