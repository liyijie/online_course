# == Schema Information
#
# Table name: teachers
#
#  id                     :integer          not null, primary key
#  phone                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  username               :string(255)      default("")
#  number                 :string(255)
#  name                   :string(255)
#  avatar                 :string(255)
#  birthday               :string(255)
#  tec_position           :string(255)
#  email                  :string(255)
#  qualification          :string(255)
#  fax                    :string(255)
#  final_education        :string(255)
#  final_degree           :string(255)
#  tec_expertise          :string(255)
#  resume                 :text(65535)
#  tec_situation          :text(65535)
#  tec_service            :text(65535)
#  deleted_at             :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  sex                    :string(255)
#  grade_id               :integer
#  signature              :text(65535)
#

class Teacher < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable


  has_many :comment, as: :usertable, dependent: :destroy
  has_one :image, as: :imageable
  has_many :teacher_courses, dependent: :destroy

  #教师学位列表
  TeacherDegree =[{text: '大专', value: 'dazhuan'}, {text: '本科', value: 'benke'}, {text: '硕士', value: 'shuoshi'}, {text: '博士', value: 'boshi'}]

  # Virtual attribute for authenticating by either username or phone
  attr_accessor :login

  validates_presence_of     :phone
  validates_uniqueness_of   :phone, case_sensitive: false
  validates :password, presence: true, length: {minimum:6,maximum: 32}, on: :create
  validates_confirmation_of :password, on: :create

  #创建teacher生成编号
  before_create do
    self.number = NumberHelper.random_course_number
  end

  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup

   login = conditions.delete(:login)

   where(conditions).where(["lower(username) = :value OR lower(phone) = :value", { :value => login.strip.downcase }]).first
  end

  #有你昵称显示昵称，没有则显示其名字
  def show_name 
    self.name
  end

   #页面头像显示
  def show_image 
    self.image.present? ? self.try(:image).try(:avatar).try(:url) : "teacher-default.jpg"
  end
end
