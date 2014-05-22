class User < ActiveRecord::Base
  # set email to lowercase to ensure uniqueness
  before_save { self.email = email.downcase }
  
  # validate name
  validates :name, presence: true, length: { maximum: 50 }
  
  # Ruby Constant starts with capital letter
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # validate email
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  
  # validates password length
  validates :password, length: { minimum: 6 }
  
  # has secure password, entire framwork rails 4 
  has_secure_password
end
