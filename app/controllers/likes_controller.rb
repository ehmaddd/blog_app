class LikesController < ApplicationController
  def create
    user = current_user
    post = Post.find(params[:post_id])

    # Ensure that the user hasn't already liked the post
    if user.likes.exists?(post: post)
      flash[:alert] = 'You have already liked this post!'
    else
      like = Like.new(author: user, post: post)

      if like.save
        flash[:notice] = 'You liked this post!'
      else
        flash[:alert] = 'Unable to like the post.'
      end
    end

    # Redirect to the post show page with updated likes count
    redirect_to user_post_path(post.author, post, likes_count: post.likes_counter)
  end
end
