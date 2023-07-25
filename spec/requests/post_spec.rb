require 'rails_helper'

RSpec.describe 'Controllers', type: :request do
  describe 'GET /posts/:id' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }

    it 'returns http success' do
      get user_post_path(user, post)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text' do
      get user_post_path(user, post)
      expect(response.body).to include('<h1>Specific Post</h1>')
    end
  end
end
