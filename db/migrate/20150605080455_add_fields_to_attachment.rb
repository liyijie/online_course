class AddFieldsToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :attachmentable_id, :integer
    add_column :attachments, :attachmentable_type, :string
  end
end
