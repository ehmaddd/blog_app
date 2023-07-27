class PostsController < ApplicationController
  before_action :set_user

  def index
    @user = User.find(params[:user_id])
    if params[:show_all] == 'true'
      @posts = @user.posts
      @show_all = true
    else
      @posts = @user.three_most_recent_posts
      @show_all = false
    end
    @comments = @posts.flat_map(&:five_most_recent_comments)
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
