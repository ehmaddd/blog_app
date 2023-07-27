class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      flash[:notice] = 'You liked this post!'
    else
      flash[:alert] = 'Unable to like the post.'
    end

    redirect_to user_post_path(@post.author, @post)
  end
end
