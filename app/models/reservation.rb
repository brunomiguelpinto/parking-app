class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :parking_spot

  enum :status, { pending: 0, approved: 1, rejected: 2 }

  validates :date, presence: true
  validates :license_plate, presence: true
  validates :user_id, uniqueness: { scope: :date, message: "ja tem uma reserva para este dia" }
  validate :date_must_be_tomorrow, on: :create
  validate :reservations_open, on: :create
  validate :spot_must_be_available, on: :create

  scope :for_date, ->(date) { where(date: date) }
  scope :upcoming, -> { where("date >= ?", Date.current).order(:date) }

  private

  def date_must_be_tomorrow
    return if date.blank?
    errors.add(:date, "so pode reservar para amanha") unless date == Date.tomorrow
  end

  def reservations_open
    errors.add(:base, "As reservas so abrem as 9h") if Time.current.hour < 9
  end

  def spot_must_be_available
    return if parking_spot.blank? || date.blank?
    unless parking_spot.available_on?(date)
      errors.add(:parking_spot, "ja esta reservado para este dia")
    end
  end
end
