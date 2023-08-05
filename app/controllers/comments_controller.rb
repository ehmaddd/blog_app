class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create

  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
