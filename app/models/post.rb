class Post < ActiveRecord::Base
	include Voteable
	
	BADWORDS = ['bad','word']
	belongs_to :user, foreign_key: :user_id
	has_many :post_categories
	has_many :categories, through: :post_categories
	has_many :comments, dependent: :destroy
	has_many :votes, as: :voteable
	validates :title, :url, :description, presence: true, length: {minimum: 5}
	after_validation :generate_slug

	def total_votes
			self.votes.where(vote: true).size - self.votes.where(vote: false).size
	end

	def bad_words
		title.split(' ').each do |word|
			if BADWORDS.include?(word)
				errors.add(:base, "Sorry, word not allowed")
				break
			end
		end
	end

	def generate_slug
		self.slug = self.title.gsub(' ', '-').downcase
	end

	def to_param
		self.slug
	end
	
end


