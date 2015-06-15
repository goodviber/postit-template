class User < ActiveRecord::Base
	has_many :posts
	has_many :comments

	has_secure_password validations: true
	validates :username, presence: true, uniqueness: true
	validates :password, :password_confirmation, presence: true, on: :create

	def admin?
		role == 'admin'
	end

	def generate_slug
		self.slug = self.username.gsub(' ', '-').downcase
	end

	
end
