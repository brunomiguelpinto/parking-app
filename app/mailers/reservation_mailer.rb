class ReservationMailer < ApplicationMailer
  default from: "Parking App <noreply@casaninja.ddns.net>"

  # Notifica todos os admins quando uma reserva é criada
  def new_reservation(reservation)
    @reservation = reservation
    @user = reservation.user
    @spot = reservation.parking_spot

    admin_emails = User.where(role: :admin, active: true).pluck(:email)
    return if admin_emails.empty?

    mail(
      to: admin_emails,
      subject: "Nova reserva pendente - #{@user.name} (#{@reservation.date.strftime('%d/%m/%Y')})"
    )
  end

  # Notifica o utilizador quando a reserva é aprovada
  def reservation_approved(reservation)
    @reservation = reservation
    @user = reservation.user
    @spot = reservation.parking_spot

    mail(
      to: @user.email,
      subject: "Reserva aprovada - Lugar #{@spot.name} (#{@reservation.date.strftime('%d/%m/%Y')})"
    )
  end

  # Notifica o utilizador quando a reserva é rejeitada
  def reservation_rejected(reservation)
    @reservation = reservation
    @user = reservation.user
    @spot = reservation.parking_spot

    mail(
      to: @user.email,
      subject: "Reserva rejeitada - #{@reservation.date.strftime('%d/%m/%Y')}"
    )
  end
end
