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
#  signature              :text(65535)
#  academy_id             :integer
#

require 'csv'
class Teacher < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  acts_as_voter

  has_many :comment, as: :usertable, dependent: :destroy
  has_one :image, as: :imageable
  has_many :teacher_courses, dependent: :destroy
  has_many :courses, through: :teacher_courses
  has_many :teacher_grades, dependent: :destroy
  has_many :grades, through: :teacher_grades
  belongs_to :academy

  has_many :papers, dependent: :destroy

  # Virtual attribute for authenticating by either username or phone
  attr_accessor :login

  validates_presence_of     :phone
  validates_uniqueness_of   :phone, case_sensitive: false
  validates_uniqueness_of   :number, case_sensitive: false
  validates :password, presence: true, length: {minimum:4,maximum: 32}, on: :create
  validates_confirmation_of :password, on: :create

  #去除number中的空格
  before_create do
    self.number = self.number.split(" ").join("")
  end

  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup

   login = conditions.delete(:login)

   where(conditions).where(["lower(number) = :value OR lower(phone) = :value", { :value => login.strip.downcase }]).first
  end

  #有你昵称显示昵称，没有则显示其名字
  def show_name
    self.name
  end

   #页面头像显示
  def show_image
    self.image.present? ? self.try(:image).try(:avatar).try(:url, :t_280_370) : "teacher-default.jpg"
  end

  #excel,csv导入功能
  def self.import(file)
    allowed_attributes = [ "number", "name", "birthday", "tec_position", "phone", "email", "final_education", "final_degree"]
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(2)
    (3..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      teacher = Teacher.new
      u_hash = row.to_hash.select { |k,v| allowed_attributes.include? k }
      u_hash["number"] = row["number"].to_i.to_s.split(" ").join("")
      u_hash["phone"] = row["phone"].to_i.to_s.split(" ").join("")
      teacher.password = "8888"
      teacher.password_confirmation = "8888"
      teacher.attributes = u_hash
      teacher.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "未知格式: #{file.original_filename}"
    end
  end

end
