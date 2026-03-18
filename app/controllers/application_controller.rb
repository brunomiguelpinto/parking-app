class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  helper_method :current_user, :logged_in?, :admin?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def admin?
    current_user&.admin?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Tens de fazer login."
    end
  end

  def require_admin
    unless admin?
      redirect_to root_path, alert: "Acesso restrito a administradores."
    end
  end
end
