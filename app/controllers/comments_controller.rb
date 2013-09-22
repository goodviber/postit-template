class CommentsController < ApplicationController

	def new
				@comment=Comment.new
	end

	def create
		@comment=Comment.new(post_params)
		if comment.save
			flash[:notice] = "You have created a comment"
			redirect_to_post_comments_path
		else
			render 'new'
		end

	end
end
