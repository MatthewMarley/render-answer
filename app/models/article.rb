class Article < ActiveRecord::Base
    belongs_to :user    
    has_many :article_categories
    has_many :articles, through: :article_categories
    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
    validates :description, presence: true, length: { minimum: 50, maximum: 10000 }
    validates :user_id, presence: true
    
end
