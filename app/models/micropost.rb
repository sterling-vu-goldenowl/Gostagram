# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user
  has_many :post_photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 65_550 }
  validates :post_photos, presence: true

  accepts_nested_attributes_for :post_photos,
                                reject_if: proc { |attributes| attributes['photo'].blank? },
                                allow_destroy: true
end
