class User < ActiveRecord::Base
  
  # set cardinality to microposts
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  # the source: of the followed users is the set of 'followed' ids
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                  class_name: "Relationship",
                                  dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  # set email to lowercase to ensure uniqueness
  before_save { self.email = email.downcase }
  
  # before a user is created, create a remember token
  before_create :create_remember_token
  
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
  
  def feed
    Micropost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end
  
  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy
  end
  
  # class methods
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  # private methods
  
  private
  
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
  
end
