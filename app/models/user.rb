class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :microposts, dependent: :destroy

  mount_uploader :avatar, PictureUploader

  validates :username, presence: true
  validates :email, presence: true
  validate :avatar_size

  def feed
    Micropost.where("user_id = ?", id)
  end

  private

  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end
end
