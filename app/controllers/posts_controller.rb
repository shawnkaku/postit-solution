class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy, :edit]
  before_action :require_user?, except: [:index, :show]
  # before_action :require_same_user, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    #@post.user = User.first

    if @post.save
      flash[:notice] = "Your post has been created!"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @post.update(post_params)
      flash[:notice] = "The post has been updated."
      redirect_to post_path(@post)
    else
      render :edit
    end

  end

  def destroy

  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [] )
  end
  def set_post
    @post = Post.find(params[:id])
  end

end
