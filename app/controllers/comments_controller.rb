class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = User.first
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
