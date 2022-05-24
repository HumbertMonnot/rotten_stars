class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :prestation
  has_many :reviews

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true, numericality: true
  validates :total, presence: true, numericality: true
  validates :state, presence: true, inclusion: { in: ["pending", "accepted", "rejected"]}
end
