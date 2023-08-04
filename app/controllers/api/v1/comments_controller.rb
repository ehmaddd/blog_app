module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user!, only: [:create]
      before_action :set_post

      def create
        comment = @post.comments.build(comment_params)
        comment.user = current_user # Use the currently logged-in user as the author

        if comment.save
          render json: comment, status: :created
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end

      def comment_params
        params.require(:comment).permit(:text)
      end
    end
  end
end
