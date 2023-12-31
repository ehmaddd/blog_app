class Post < ApplicationRecord
  attribute :content, :text

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :author_id, presence: true

  after_create :update_post_counter

  def update_post_counter
    author.increment!(:posts_counter, 1)
  end

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
