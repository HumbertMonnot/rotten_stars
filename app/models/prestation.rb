class Prestation < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_one_attached :poster

  validates :name, presence: true
  validates :category, inclusion: { in: ['sing', 'danse'] }
  validates :description, presence: true, length: { in: 150..300 }
  validates :price, numericality: true
  validates :address, presence: true
  validates :distance, numericality: true
  validates :punchline, presence: true, length: { in: 5..30 }

  def average
    average = []
    self.reservations.each do |reservation|
      reservation.reviews.each do |review|
        average << review.rating
      end
    end
    if average.size.positive?
      final_average = average.sum / average.size
      return final_average
    end
    return "No rating yet !"
  end
end
