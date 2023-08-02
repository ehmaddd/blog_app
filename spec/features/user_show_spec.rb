require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let(:user) { create(:user) }
  let!(:user_posts) { create_list(:post, 89, author_id: user.id) }

  before do
    visit user_path(user)
    user.update(posts_counter: user.posts.count)
  end

  it 'displays the user\'s picture' do
    expect(page).to have_selector('img.user_img')
  end

  it 'displays the user\'s username' do
    expect(page).to have_content(user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content("Number of Posts: #{user.posts_counter}")
  end

  it 'displays the user\'s bio' do
    expect(page).to have_content(user.bio)
  end

  it 'displays the user\'s first 3 posts' do
    user.posts.order(created_at: :desc).limit(3).each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'displays a button to view all of the user\'s posts' do
    expect(page).to have_link('See All Posts', href: user_posts_path(user))
  end

  it 'redirects to the post show page when clicking a user\'s post' do
    post = user.posts.first
    first(:link, "Post: #{post.title}", class: 'each_post_detail').click
    expect(page).to have_content(post.title)
  end

  it 'redirects to the user\'s posts index page when clicking to see all posts' do
    click_link('See All Posts')
    expect(page).to_not have_link('Pagination', href: user_posts_path(user))
  end
end
