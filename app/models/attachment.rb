# == Schema Information
#
# Table name: attachments
#
#  id                   :integer          not null, primary key
#  sub_course_id        :integer
#  content              :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  content_file_name    :string(255)
#  content_content_type :string(255)
#  content_file_size    :integer
#  attachmentable_id    :integer
#  attachmentable_type  :string(255)
#

class Attachment < ActiveRecord::Base
  belongs_to :attachmentable, polymorphic: true

  has_attached_file :content, :styles => {
    :c_860_500 => { :geometry => "860x500", :format => 'jpg', :time => 10 },
    :c_260_140 => { :geometry => "260x140", :format => 'jpg', :time => 10 },
    :thumb => { :geometry => "100x100", :format => 'jpg', :time => 10 },
    :c_350_230 => { :geometry => "350x230", :format => 'jpg', :time => 10 },    #首页课程展示图
    :c_500_350 => { :geometry => "500x350", :format => 'jpg', :time => 10 },
    :c_420_285 => { :geometry => "420x285", :format => 'jpg', :time => 10 },    #课程展示页展示图
    :c_340_200 => { :geometry => "340x200", :format => 'jpg', :time => 10 }     #教师展示页课程图片
  }, :processors => [:ffmpeg]

  validates_attachment :content, :content_type => {:content_type => %w()}
end
