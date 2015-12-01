# == Schema Information
#
# Table name: users
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
#  name                   :string(255)
#  avatar                 :string(255)
#  position               :string(255)
#  number                 :string(255)
#  grade_id               :integer
#  deleted_at             :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  nickname               :string(255)
#  gender                 :boolean          default(TRUE)
#  signature              :text(65535)
#  campus                 :string(255)
#

require 'csv'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  acts_as_voter

  belongs_to :grade
  has_one :image, as: :imageable
  has_many :exams, dependent: :destroy

  has_many :comment, as: :usertable, dependent: :destroy

  has_many :user_papers, dependent: :destroy
  has_many :papers, through: :user_papers

  # Virtual attribute for authenticating by either username or phone
  attr_accessor :login

  attr_accessor :academy_id
  attr_accessor :specialty_id

  validates_presence_of     :number
  validates_uniqueness_of   :number, case_sensitive: false
  validates :password, presence: true, length: { minimum:4, maximum: 32 }, on: [:create, :update_password]
  validates_confirmation_of :password, on: [:create, :update_password]
  validates_uniqueness_of   :number
  validates_associated :image

  scope :keyword_like, -> (keyword) do
    return all if keyword.blank?
    where(
      'users.number LIKE ?
      OR users.name LIKE ?
      OR users.phone LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end



  #用户权限划分
  # enum role: { system: 1, teacher: 2, student: 3}
  # ROLE = { system: "管理员", teacher: "教师", student: "学生"}

  enum gender: {man: true, woman: false}
  PartnerGender = {man: '男', woman: '女'}

   #页面头像显示
  def show_image
    self.image.present? ? self.try(:image).try(:avatar).try(:url, :u_145x145) : "user-default.jpg"
  end

  #有你昵称显示昵称，没有则显示其名字
  def show_name
    self.nickname || self.name
  end

  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup

   login = conditions.delete(:login)

   where(conditions).where(["lower(number) = :value OR lower(phone) = :value", { :value => login.strip.downcase }]).first
  end

  #excel导入
  def self.import(file)
    grade_arr = []
    allowed_attributes = ["number", "name", "phone", "gender", "campus"]
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(2)

    error_line = 0
    error_message = ""

    #创建用户对象，存入班级的值
    begin
      User.transaction do
        (3..spreadsheet.last_row).each do |i|
          error_line = i
          row = Hash[[header, spreadsheet.row(i)].transpose]
          user = User.new
          #创建grade班级对象， 存入专业的值
          specialty = Specialty.find_by(code: row["specialty"].to_i.to_s)

          grade_name = row["grade1"].to_i.to_s + "级" + row["grade2"].to_s[1] +"班"
          grade = specialty.grades.find_by(name: grade_name)
          if grade.present?
            grade.name = grade_name
            grade.specialty_id = specialty.id
          else
            grade = Grade.new(name: grade_name, specialty_id: specialty.id)
          end

          #创建用户，将grade_id存入用户
          grade.save!
          user.grade_id = grade.id

          #初始化hash
          u_hash = row.to_hash.select { |k,v|
           allowed_attributes.include? k
          }
          u_hash["gender"] = User::PartnerGender.key(u_hash["gender"])
          #修复纯数字execl会默认加.0的情况,处理输入带有空格的bug
          u_hash["number"] = row["number"].to_i.to_s.strip
          u_hash["phone"] = row["phone"].present? ? row["phone"].to_i.to_s.strip : "189#{i.to_s}1"
          user.password = 8888
          user.password_confirmation = 8888
          user.attributes = u_hash
          user.save!
        end
      end
    rescue Exception => e
      puts "================= student import error start =============="
      puts "error_line:#{error_line}" + e.message
      puts "================= student import error end =============="
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

  def self.quantities(current_user)
    cache = {}
    cache[:course] = Course.count
    cache[:collect_course] = current_user.find_up_voted_items(vote_scope: :collect, votable_type: :Course).count
    cache[:exams] = current_user.try(:exams).count
    cache[:question_comments] = Comment.find_root_comments_by_usertable(current_user, :answer).count
    cache[:answer_comments] = Comment.find_answer_by_usertable(current_user).count
    return cache
  end
end
