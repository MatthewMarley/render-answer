class Category < ActiveRecord::Base
    has_many :article_categories
    has_many :articles, through: :article_categories
    validates :name, presence: true, length: { maximum: 50 }
    validates_uniqueness_of :name
end