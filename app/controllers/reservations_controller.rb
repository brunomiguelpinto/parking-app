class ReservationsController < ApplicationController
  before_action :require_login

  def new
    @reservation = current_user.reservations.build(date: Date.tomorrow)
    @available_spots = ParkingSpot.active.select { |s| s.available_on?(Date.tomorrow) }
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.date = Date.tomorrow
    @reservation.license_plate = current_user.license_plate if @reservation.license_plate.blank?

    if @reservation.save
      ReservationMailer.new_reservation(@reservation).deliver_later
      redirect_to root_path, notice: "Reserva criada com sucesso! Aguarda aprovacao."
    else
      @available_spots = ParkingSpot.active.select { |s| s.available_on?(Date.tomorrow) }
      render :new, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:parking_spot_id, :license_plate)
  end
end
