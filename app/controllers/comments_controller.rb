class CommentsController < ApplicationController
	before_action :require_user, only: [:new, :create]

	def new
				@comment=Comment.new
	end

	def create
		@post = Post.find(params[:post_id])
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

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
