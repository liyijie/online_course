class AddFileUrlToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :file_url, :string
  end
end
