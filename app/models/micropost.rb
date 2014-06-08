class Micropost < ActiveRecord::Base
  
  # a user can have many microposts
  belongs_to :user
  
  default_scope -> { order('created_at DESC') }
  
  validates :user_id, presence: true
  
  validates :content, presence: true, length: { maximum: 140 }
  
  # Returns 
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                          where follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
      user_id: user)
  end
  
end