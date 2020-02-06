class PostPhoto < ApplicationRecord
  mount_uploader :photo, PictureUploader

  belongs_to :micropost

  validates :photo, presence: true
  validate :photo_size_validation
end

def photo_size_validation
  errors[:photo] << 'Photo should be less than 5MB' if photo.size > 5.megabytes
end
