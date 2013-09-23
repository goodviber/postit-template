class Post < ActiveRecord::Base
	belongs_to :user, foreign_key: :user_id
	has_many :categories, through: :post_categories
	has_many :comments, dependent: :destroy
	validates :title, :url, :description, presence: true, length: {minimum: 5}
end