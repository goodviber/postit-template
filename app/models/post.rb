class Post < ActiveRecord::Base
	
	BADWORDS = ['bad','word']
	belongs_to :user, foreign_key: :user_id
	has_many :post_categories
	has_many :categories, through: :post_categories
	has_many :comments, dependent: :destroy
	has_many :votes, as: :voteable
	validates :title, :url, :description, presence: true, length: {minimum: 5}

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
end

