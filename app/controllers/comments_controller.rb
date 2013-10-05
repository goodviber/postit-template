class CommentsController < ApplicationController
	before_action :require_user, only: [:new, :create, :vote]

	def new
				@comment=Comment.new
	end

	def create
		@post = Post.find_by slug: params[:post_id]
		@comment = Comment.new(comment_params)
		@comment.post = @post

		@comment.user = current_user

		if @comment.save
			flash[:notice] = "You have created a comment"
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end

	end

	def vote
				@comment = Comment.find(params[:id])
		Vote.create(vote: params[:vote], user: current_user, voteable: @comment)

		respond_to do |format|
			format.html do
				flash[:notice] = "You have voted succesfully."
				redirect_to request.referer
			end
			format.js
		end
	end



	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
