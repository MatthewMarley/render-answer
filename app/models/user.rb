class User < ApplicationRecord
  # has_many + dependent means if a user is removed from the db, 
  # all associated articles will also be removed
  has_many :articles, dependent: :destroy
  
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
  
  def full_name
  end
  
end
