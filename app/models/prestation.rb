require 'open-uri'
require "json"

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

  def polygon
    url_base = "https://api.mapbox.com/isochrone/v1/mapbox/"
    url = "#{url_base}driving/#{self.longitude},#{self.latitude}?contours_minutes=#{self.distance}&polygons=true&access_token=#{ENV["MAPBOX_API_KEY"]}"
    request = URI.open(url).read
    response = JSON.parse(request)
    return response["features"][0]["geometry"]["coordinates"][0]
  end

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
