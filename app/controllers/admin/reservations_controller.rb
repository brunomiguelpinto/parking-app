module Admin
  class ReservationsController < BaseController
    def index
      @pending = Reservation.pending.for_date(Date.tomorrow).includes(:user, :parking_spot).order(:created_at)
      @all_reservations = Reservation.upcoming.includes(:user, :parking_spot).order(date: :asc, created_at: :asc)
    end

    def approve
      reservation = Reservation.find(params[:id])
      reservation.approved!
      ReservationMailer.reservation_approved(reservation).deliver_later
      redirect_to admin_reservations_path, notice: "Reserva aprovada."
    end

    def reject
      reservation = Reservation.find(params[:id])
      reservation.rejected!
      ReservationMailer.reservation_rejected(reservation).deliver_later
      redirect_to admin_reservations_path, notice: "Reserva rejeitada."
    end
  end
end
