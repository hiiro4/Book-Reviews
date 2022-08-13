class User < ApplicationRecord

  has_many :relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "be_followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :be_followed
  has_many :followers, through: :reverse_of_relationships, source: :following

  has_many :reviews
  has_many :favorites, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # フォローしたとき
  def follow(user_id)
    relationships.create(be_followed_id:user_id)
  end
  # フォローを外すとき
  def unfollow(user_id)
    relationships.find_by(be_followed_id:user_id).destroy
  end

  # フォローしているか
  def following?(user)
    followings.include?(user)
  end
end
