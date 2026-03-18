class ParkingSpot < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }

  def available_on?(date)
    !reservations.where(date: date, status: [:pending, :approved]).exists?
  end
end
