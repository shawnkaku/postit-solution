class CommentsController < ApplicationController
  before_action :require_user?, only: [:new, :create]

  def new
    @comment = Comment.new
  end
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post

    if @comment.save
      flash[:notice] = "Comment has been created!"
      redirect_to post_path(@post)
    else
      render :new
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

end
