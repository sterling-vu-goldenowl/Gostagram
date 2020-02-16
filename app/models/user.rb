class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include PgSearch::Model
  pg_search_scope :search_user,
                  against: :username,
                  using: {
                    tsearch: { prefix: true }
                  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  mount_uploader :avatar, PictureUploader

  validates :name, presence: true
  validates :username, presence: true,
                       format: { without: /\s/, message: 'must contain no spaces' }
  validates :email, presence: true
  validate  :avatar_size

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    following_ids = Relationship.where(follower_id: id).pluck(:followed_id)
    Micropost.where(user_id: following_ids).or(Micropost.where(user_id: id))
    # following_ids = Relationship.where(follower_id: id).select(:followed_id).to_sql
    # Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  private

  def avatar_size
    return if avatar.size <= 5.megabytes

    errors.add(:avatar, 'should be less than 5MB')
  end
end
