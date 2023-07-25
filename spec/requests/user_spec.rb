require 'rails_helper'

RSpec.describe 'Controllers', type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, author: user) }

  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/'
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text' do
      get '/'
      expect(response.body).to include('<h1>Welcome to the Home Page!</h1>')
    end
  end

  describe 'GET /users' do
    it 'returns http success' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text' do
      get users_path
      expect(response.body).to include('<h1>User Details:</h1>')
    end
  end

  describe 'GET /users/:id' do
    let(:user) { create(:user) }

    it 'returns http success' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text' do
      get user_path(user)
      expect(response.body).to include('<h1>Here are the posts for user</h1>')
    end
  end

  describe 'GET /users/:user_id/posts' do
    let(:user) { create(:user) }

    it 'returns http success' do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text' do
      get user_posts_path(user)
      expect(response.body).to include('<h1>Here are the posts for user @posts</h1>')
    end
  end
end
