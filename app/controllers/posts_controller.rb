class PostsController < ApplicationController
  before_action :set_user

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @comments = @posts.flat_map(&:five_most_recent_comments)
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
