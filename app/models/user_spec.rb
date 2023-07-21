require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments).with_foreign_key('author_id') }
    it { should have_many(:likes).with_foreign_key('author_id') }
  end

  describe '#three_most_recent_posts' do
    let!(:user) { create(:user) }
    let!(:recent_posts) { create_list(:post, 5, author: user) }
    let!(:old_posts) { create_list(:post, 3, author: user, created_at: 1.month.ago) }

    it 'returns three most recent posts by the user' do
      expect(user.three_most_recent_posts).to eq(recent_posts.reverse)
    end
  end
end
