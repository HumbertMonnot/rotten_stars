class Prestation < ApplicationRecord
  belongs_to :user
  has_one_attached :poster

  validates :name, presence: true
  validates :category, inclusion: { in: ['sing', 'danse'] }
  validates :description, presence: true, length: { in: 150..300 }
  validates :price, numericality: true
  validates :address, presence: true
  validates :distance, numericality: true
  validates :punchline, presence: true, length: { in: 5..30 }
end
