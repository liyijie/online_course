class AddPaperclipFieldsToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :content_file_name, :string
    add_column :attachments, :content_content_type, :string
    add_column :attachments, :content_file_size, :integer
  end
end
