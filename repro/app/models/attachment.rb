class Attachment < ApplicationRecord
  has_one_attached :attachment

  validates :attachment, presence: true
end