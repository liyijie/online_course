# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  phone                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  username               :string           default("")
#  role                   :integer          not null
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable


  belongs_to :grade

  # Virtual attribute for authenticating by either username or phone
  attr_accessor :login

  validates_presence_of     :phone
  validates_uniqueness_of   :phone, case_sensitive: false
  validates :password, presence: true, length: {minimum:6,maximum: 32}
  validates_confirmation_of :password


  #用户权限划分
  # enum role: { system: 1, teacher: 2, student: 3}
  # ROLE = { system: "管理员", teacher: "教师", student: "学生"}


  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup

   login = conditions.delete(:login)

   where(conditions).where(["lower(username) = :value OR lower(phone) = :value", { :value => login.strip.downcase }]).first
  end
end
