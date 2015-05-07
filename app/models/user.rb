class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  # Virtual attribute for authenticating by either username or phone
  attr_accessor :login


  #用户权限划分
  enum role: { system: 1, teacher: 2, student: 3}
  ROLE = { system: "管理员", teacher: "教师", student: "学生"}


  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup
   login = conditions.delete(:login)
   where(conditions).where(["lower(username) = :value OR lower(phone) = :value", { :value => login.strip.downcase }]).first
 end
end
