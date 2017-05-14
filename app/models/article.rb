class Article < ActiveRecord::Base
    belongs_to :user    
    has_many :article_categories
    has_many :categories, through: :article_categories
    has_many :comments, dependent: :destroy
    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
    validates :description, presence: true, length: { minimum: 50, maximum: 10000 }
    validates :user_id, presence: true
    acts_as_votable
end
