# == Schema Information
#
# Table name: managers
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  roles                  :string(255)
#  number                 :string(255)
#  name                   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class Manager < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login
  has_many :manager_courses, dependent: :destroy
  has_many :courses, through: :manager_courses

  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup

   login = conditions.delete(:login)

   where(conditions).where(["lower(number) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
  end

  enum roles: {
	  administer: '0',
	  charge: '1',
	  teacher: '2'
	}

	ListRoles = {
		administer: '管理员',
	  charge: '课程负责人',
	  teacher: '课程教师'
	}

  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    where(
      'managers.number LIKE ?
      OR managers.name LIKE ?
      OR managers.email LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end
end
