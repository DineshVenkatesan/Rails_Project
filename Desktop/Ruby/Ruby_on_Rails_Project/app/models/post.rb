class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title, :description, :image, presence: true
  has_many :comments, dependent:  :destroy
  has_many :users, through: :comments

  def next
    Post.where("id > ?", id).order(id: :asc).limit(1).first
  end

  def prev
    Post.where("id < ?", id).order(id: :desc).limit(1).first
  end
end
