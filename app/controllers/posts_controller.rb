class PostsController < ApplicationController
  before_action :set_user

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
