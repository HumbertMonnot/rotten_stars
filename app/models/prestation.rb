class Prestation < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_one_attached :poster
  
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, presence: true
  validates :category, inclusion: { in: ['sing', 'danse'] }
  validates :description, presence: true, length: { in: 150..300 }
  validates :price, numericality: true
  validates :address, presence: true
  validates :distance, numericality: true
  validates :punchline, presence: true, length: { in: 5..30 }
end
