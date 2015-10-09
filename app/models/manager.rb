class Manager < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login

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
end
