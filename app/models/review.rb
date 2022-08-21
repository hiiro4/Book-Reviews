class Review < ApplicationRecord

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user


  validates :title, presence: true
  validates :body, presence: true
  validates :assess, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
