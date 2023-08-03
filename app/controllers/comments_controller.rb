class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to @post, notice: 'Comment created successfully.'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment # Ensure user is authorized to delete the comment

    if @comment.destroy
      flash[:notice] = "Comment was successfully deleted."
    else
      flash[:alert] = "Unable to delete the comment."
    end

    redirect_to user_post_path(@post.author, @post)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
