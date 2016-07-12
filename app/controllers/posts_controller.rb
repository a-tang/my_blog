class PostsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]
before_action :find_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    if params[:search]
      @posts = @posts.search(params[:search]).order("created_at DESC")
    else
      @posts = @posts.order('created_at DESC')
    end
    @posts = @posts.page(params[:page]).per(10)
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
    # @post     = Post.find params[:id]
    @comment  = Comment.new
    respond_to do |format|
      format.html { render } # render posts/show.html.erb
      format.json { render json: @post.to_json }
      format.xml  { render xml: @post.to_xml }
    end
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
    params.require(:post).permit([:title, :body, :image, :category_id, {tag_ids: []}])
  end

  def user_favourite
    @user_favourite ||= @post.favourite_for(current_user)
  end
  helper_method :user_favourite

end
