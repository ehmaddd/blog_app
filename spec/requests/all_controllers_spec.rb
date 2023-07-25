require 'rails_helper'

RSpec.describe 'All controllers', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /users' do
    it 'returns HTTP success' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Welcome to the Home Page!')
    end
  end

  describe 'GET /users/:id' do
    it 'returns HTTP success' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_path(user)
      expect(response.body).to include('User Details:') # Replace with the actual placeholder text in your template
    end
  end

  describe 'GET /users/:user_id/posts' do
    it 'returns HTTP success' do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(user)
      expect(response.body).to include('Here are the posts for user')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    let!(:post) { create(:post, user:) }

    it 'returns HTTP success' do
      get user_post_path(user, post)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_post_path(user, post)
      expect(response.body).to include('Post Details:')
    end
  end
end
