class DashboardController < ApplicationController
  before_action :require_login

  def show
    @reservations = current_user.reservations.upcoming.includes(:parking_spot)
    @can_reserve = Time.current.hour >= 9 && !current_user.reservations.exists?(date: Date.tomorrow)
  end
end
