class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:comments).order(created_at: :desc).limit(3)
  end
end
