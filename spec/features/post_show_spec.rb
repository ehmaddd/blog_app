require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  include Rails.application.routes.url_helpers
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let!(:comments) { create_list(:comment, 5, post:) }

  before do
    visit "users/#{user.id}/posts/#{post.id}"
  end

  it 'displays the post\'s title' do
    expect(page).to have_content(post.title)
  end

  it 'displays the author of the post' do
    expect(page).to have_content(post.author.name)
  end

  it 'displays the number of comments the post has' do
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end

  it 'displays the number of likes the post has' do
    expect(page).to have_content("Likes: #{post.likes_counter}")
  end

  it 'displays the post body' do
    expect(page).to have_content(post.text)
  end

  it 'displays the username of each commentor' do
    comments.each do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end

  it 'displays the comment each commentor left' do
    comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
