class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :vote]
	before_action :require_user, only: [:new, :create, :edit, :update, :vote]

  def new
		@post = Post.new
	end

	def create
	  @post = Post.new(post_params)
	  @post.user = current_user
	 
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
	  respond_to do |format|
	  	format.html {render :index}
	  	format.js {render json: @posts}
	  	format.xml {render xml: @posts}
	  	format.json {render json: @posts}
	  end
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

	def vote
		Vote.create(vote: params[:vote], user: current_user, voteable: @post)

		respond_to do |format|
			format.html do
				flash[:notice] = "You have voted succesfully."
				redirect_to root_path
			end
			format.js
		end
	end


	def destroy
	  @post = Post.find(params[:id])
	  @post.destroy
	 
	  redirect_to posts_path
	end

	private

	def set_post
		@post = Post.find_by slug: params[:id]
	end

  def post_params
    params.require(:post).permit!
  end
end
