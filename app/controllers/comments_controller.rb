class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.all
  end

  def create
    comment_params = @comment.require(:comment).permit([:title, :body])
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to comment_path(@comment)
    else
      render :new
  end

  def show
    @comment = Comment.find params[:id]
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def udpate
    @comment = Comment.find params[:id]
    comment_params = params.require(:comment).permit([:title, :body])
    if @comment.update comment_params
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to comments_path
  end

end
