class Teacher < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable


  # Virtual attribute for authenticating by either username or phone
  attr_accessor :login

  validates_presence_of     :phone
  validates_uniqueness_of   :phone, case_sensitive: false
  validates :password, presence: true, length: {minimum:6,maximum: 32}
  validates_confirmation_of :password



  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup

   login = conditions.delete(:login)

   where(conditions).where(["lower(username) = :value OR lower(phone) = :value", { :value => login.strip.downcase }]).first
  end
end
