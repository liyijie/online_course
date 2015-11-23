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

  #t_开头的为teachers头像切图 #c_开头的为课程展示图片切图
  has_attached_file :avatar, :styles => {
  	                                    :t_60 => "60x60", #课程展示页教师团队图
  	                                    :t_170_220 => "170x220", #首页教师列表图
                                        :t_110_110 => "110x110", #首页教师列表图小图
                                        :t_220_220 => "220x220", #首页教师列表图大图
                                        :t_280_370 => "280x370", #教师个人信息
  	                                    :c_350_230 => "350x230", #首页课程展示图
                                        :c_500_350 => "500x350", #首页课程展示图
  	                                    :c_420_285 => "420x285", #课程展示页展示图
                                        :c_340_200 => "340x200", #教师展示页课程图片
  	                                    :medium => "300x300>",
  	                                    :thumb => "150x150>",
                                        :u_145x145 => "145x145>"
  	                                    },
  	                         :default_url => "/images/missing/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
