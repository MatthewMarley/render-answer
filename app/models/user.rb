class User < ApplicationRecord
  # has_many + dependent means if a user is removed from the db, 
  # all associated articles will also be removed
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :friendships
  has_many :friends, through: :friendships
  
  # Store details in lowercase to make it easier to check for unique
  # usernames and passwords
  before_save { self.email = email.downcase }
  
  validates :username, presence: true,
                      uniqueness: { case_sensitive: true },
                      length: { minimum: 3, maximum: 20 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, length: { maximum: 50 },    
                      uniqueness: { case_sensitive: false },
                      format: { with: VALID_EMAIL_REGEX }      
                      
  has_secure_password
  
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: :default_image
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  def full_name
  end
  
  def related_articles
    friends_articles = friends.map{|f| f.articles}
    return (articles.to_a + friends_articles).flatten
  end
  
  def default_image
    "pepe.png"
  end
  
  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end
  
  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end
  
  def self.search(param)
    return User.none if param.blank?
    param.strip!
    param.downcase!
    (first_name_matches(param) + last_name_matches(param) + email_matches(param) + username_matches(param)).uniq
  end
  
  def self.first_name_matches(param)
    matches('first_name', param)
  end
  
  def self.last_name_matches(param)
    matches('last_name', param)
  end
  
  def self.email_matches(param)
    matches('email', param)
  end
  
  def self.username_matches(param)
    matches('username', param)
  end
  
  def self.matches(field_name, param)
    where("lower(#{field_name}) like?", "%#{param}%")
  end
  
end
