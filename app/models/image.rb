# == Schema Information
#
# Table name: images
#
#  id                  :integer          not null, primary key
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  imageable_id        :integer
#  imageable_type      :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "150x150>" }, :default_url => "missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
