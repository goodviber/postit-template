class Post < ActiveRecord::Base
	belongs_to :user, foreign_key: :user_id
	has_many :comments, dependent: :destroy
	has_many :categories, through: :post_categories
	validates :title, :url, :description, presence: true, length: {minimum: 5}
end