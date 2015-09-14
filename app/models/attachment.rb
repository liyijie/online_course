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
#  file_url             :string(255)
#

class Attachment < ActiveRecord::Base
  belongs_to :attachmentable, polymorphic: true

  has_attached_file :content, styles: lambda { |a| a.instance.check_file_type}

  validates_attachment :content, :content_type => {:content_type => %w()}

  def check_file_type
  	if is_video_type?
  		{
		    :c_860_500 => { :geometry => "860x500", :format => 'jpg', :time => 10, :processors => [:ffmpeg] },
		    :c_260_140 => { :geometry => "260x140", :format => 'jpg', :time => 10, :processors => [:ffmpeg] },
		    :thumb => { :geometry => "100x100", :format => 'jpg', :time => 10, :processors => [:ffmpeg] },
		    :c_350_230 => { :geometry => "350x230", :format => 'jpg', :time => 10, :processors => [:ffmpeg] },    #首页课程展示图
		    :c_500_350 => { :geometry => "500x350", :format => 'jpg', :time => 10, :processors => [:ffmpeg] },
		    :c_420_285 => { :geometry => "420x285", :format => 'jpg', :time => 10, :processors => [:ffmpeg] },    #课程展示页展示图
		    :c_340_200 => { :geometry => "340x200", :format => 'jpg', :time => 10, :processors => [:ffmpeg] }     #教师展示页课程图片
	    }
	   else
	   	{}
  	end
  end

  def is_video_type?
    content_content_type =~ /^video/
  end
end
