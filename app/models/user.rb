class User < ApplicationRecord
  # has_many + dependent means if a user is removed from the db, 
  # all associated articles will also be removed
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  
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
  
  def default_image
    "pepe.png"
  end
  
end
