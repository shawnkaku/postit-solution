class CommentsController < ApplicationController
  before_action :set_comment, only: [:vote]
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
  def vote
    @vote = Vote.create(voteable: @comment, user_id: current_user.id, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted."
        else
          flash[:error] = "Your vote was not counted."
        end
        redirect_to :back
      end
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
  def set_comment
    @comment = Comment.find(params[:id])
  end
end
