require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before do
    # Create test users and posts using FactoryBot
    @user1 = FactoryBot.create(:user, name: 'user1')
    @user2 = FactoryBot.create(:user, name: 'user2')
    @user1_post1 = FactoryBot.create(:post, author_id: @user1.id)
    @user1_post2 = FactoryBot.create(:post, author_id: @user1.id)
    @user2_post1 = FactoryBot.create(:post, author_id: @user2.id)
  end

  it 'displays the username of all other users' do
    visit users_path
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it 'displays the profile picture for each user' do
    visit users_path
    expect(page).to have_css("img[src*='#{@user1.photo}']")
    expect(page).to have_css("img[src*='#{@user2.photo}']")
  end

  it 'displays the number of posts each user has written' do
    visit users_path
    expect(page).to have_content(/Posts: \d+/, count: 4)
  end

  it 'redirects to the user show page when clicking on a user' do
    visit users_path
    click_link(@user1.name)
    expect(page).to have_current_path(user_path(@user1))
  end
end
