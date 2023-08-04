class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user

  def create
    @post = @current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post # Ensure user is authorized to delete the post

    if @post.destroy
      flash[:notice] = 'Post was successfully deleted.'
    else
      flash[:alert] = 'Unable to delete the post.'
    end

    redirect_to user_path(@post.author)
  end

  def new
    @post = Post.new
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
    @comments = @posts.flat_map(&:five_most_recent_comments)
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
