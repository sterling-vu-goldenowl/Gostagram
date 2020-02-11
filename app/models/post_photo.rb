class PostPhoto < ApplicationRecord
  mount_uploader :photo, PictureUploader

  belongs_to :micropost

  validates :photo, presence: true
  validate :photo_size_validation
end

def photo_size_validation
  return if photo.size <= 5.megabytes

  errors.add(:photo, 'should be less than 5MB')
end
