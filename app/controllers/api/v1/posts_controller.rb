# app/controllers/api/v1/posts_controller.rb
module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_user

      def index
        posts = @user.posts
        render json: posts, each_serializer: PostSerializer
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end
    end
  end
end
