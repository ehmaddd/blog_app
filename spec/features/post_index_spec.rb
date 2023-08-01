require 'rails_helper'

RSpec.describe 'User post index page', type: :feature do
  let(:user) { create(:user) }
  let!(:user_posts) { create_list(:post, 15, :with_comments, :with_likes, author: user) }

  before do
    user.update(photo: 'user_avatar.png')
    create_user_posts_comments_likes(user)
    visit user_posts_path(user)
  end

  it 'displays the user\'s profile picture' do
    expect(page).to have_css('img.user_img[src="user_avatar.png"]')
  end

  it 'displays the user\'s username' do
    expect(page).to have_content(user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content('Number of Posts: 30')
  end

  it 'displays a post\'s title and some of its body' do
    user.posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text.truncate(50))
    end
  end

  it 'displays the first comments on a post' do
    user.posts.each do |post|
      comments = post.comments.order(created_at: :asc).limit(2) # Assuming 2 comments for each post
      comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end

  it 'displays how many comments and likes a post has' do
    user.posts.each do |post|
      expect(page).to have_content("Comments: #{post.comments_counter}")
      expect(page).to have_content("Likes: #{post.likes_counter}")
    end
  end

  it 'displays a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_css('.pagination')
  end

  it 'redirects to the post show page when clicking on a post' do
    post = user.posts.first
    first(:link, "Title: #{post.title}").click
    expect(page).to have_css('.individual_header')
  end

  def create_user_posts_comments_likes(user)
    posts = create_list(:post, 15, author_id: user.id)
    posts.each do |post|
      create_list(:comment, 2, post:)
      create_list(:like, 5, post:)
    end
  end
end
