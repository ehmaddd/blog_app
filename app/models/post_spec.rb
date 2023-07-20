require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe '#update_post_counter' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, author: user) }

    it 'increments the posts_counter of the user after saving a post' do
      expect { post.save }.to change { user.posts_counter }.by(1)
    end
  end

  describe '#five_most_recent_comments' do
    let!(:post) { create(:post) }
    let!(:recent_comments) { create_list(:comment, 5, post:) }
    let!(:old_comments) { create_list(:comment, 3, post:, created_at: 1.month.ago) }

    it 'returns five most recent comments on the post' do
      expect(post.five_most_recent_comments).to eq(recent_comments.reverse)
    end
  end
end
