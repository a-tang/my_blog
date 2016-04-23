class PostsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]
before_action :find_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    if params[:search]
        @posts = Post.search(params[:search]).order("created_at DESC")
      else
        @posts = Post.all.order('created_at DESC')
    end
        @posts = Post.page(params[:page]).per(10)
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post), notice: "Post created!"
    else
      flash[:alert] = "Post didn't save!"
      render :new
    end
  end

  def show
    @post     = Post.find params[:id]
    @comment  = Comment.new
  end

  def edit

  end

  def update
    @post = Post.find params[:id]
    post_params = params.require(:post).permit([:title, :body])
    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def find_owner_post
    @post = current_user.posts.find params[:id]
  end


  def post_params
    params.require(:post).permit([:title, :body, :category_id])
  end

  def user_favourite
    @user_favourite ||= @post.favourite_for(current_user)
  end
  helper_method :user_favourite

end
