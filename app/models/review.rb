class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reservation

  validates :rating, numericality: true
  validates :comment, presence: true, length: { in: (5...200) }
end
