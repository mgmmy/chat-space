class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :message, presence: true, unless: :image?
  validates :group, presence: true
  validates :user, presence: true
  mount_uploader :image, ImageUploader
end
