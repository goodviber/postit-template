class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update]

  def new
		@post = Post.new
	end

	def create
	  @post = Post.new(post_params)
	 
	  if @post.save
	  	flash[:notice] = "You have created a new post"
	  	redirect_to root_path
		else
		 render 'new'
		end
	end

	def show
		@comment = Comment.new
	end

	def index
	  @posts = Post.all
	end

	def edit
	end

	def update
	 
	  if @post.update(post_params)
	    redirect_to @post
	  else
	    render 'edit'
	  end
	end

	def destroy
	  @post = Post.find(params[:id])
	  @post.destroy
	 
	  redirect_to posts_path
	end
 
private

	def set_post
		@post = Post.find(params[:id])
	end

  def post_params
    params.require(:post).permit!
  end
end
