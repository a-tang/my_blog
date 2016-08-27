class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_post
    before_action :find_and_authorize_comment, only: :destroy

    def create
        @post             = Post.find params[:post_id]
        comment_params    = params.require(:comment).permit(:body)
        @comment          = Comment.new comment_params
        @comment.post     = @post
        @comment.user     = current_user
        respond_to do |format|
            if @comment.save
                # redirect_to post_path(@post), notice: "Thanks for answering"
                format.html { redirect_to post_path(@post), notice: "Thanks for commenting" }
                format.js { render :create_success }
            else
                flash[:alert]   = "Not saved"
                # render "/posts/show"
                format.html { render "/posts/show" }
                format.js { render :create_failure }
            end
        end
    end

    def destroy
        @comment.destroy
        respond_to do |format|
            format.html { redirect_to post_path(@post), notice: "Comment deleted!" }
            format.js { render }
        end
    end

    def show
        @comment = Comment.find params[:id]
    end

    def edit
        @comment = Comment.find params[:id]
    end

    def update
        @comment = Comment.find params[:id]
        comment_params = params.require(:comment).permit([:body])
        respond_to do |format|
            if @comment.update comment_params
                format.html { redirect_to comment_path(@comment), notice: "Thanks for commenting" }
                format.js { render :update_success }
            else
                format.html { render "/comments/edit" }
                format.js { render :update_failure }
            end
        end
    end

  private

    def find_post
        @post = Post.find params[:post_id]
    end

    def find_and_authorize_comment
    # head will stop the HTTP request and send a response code depending on the
    # symbole (first argument) that you pass in.
    # head :unauthorized unless can? :destroy, @answer
        @comment = @post.comments.find params[:id]
        redirect_to home_path unless can? :destroy, @comment
    end

end
