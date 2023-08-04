module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all
        render json: users
      end
      def posts
        user = User.find(params[:user_id])
        posts = user.posts
        render json: posts
      end
    end
  end
end
