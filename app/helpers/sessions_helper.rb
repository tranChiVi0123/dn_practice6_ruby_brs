module SessionsHelper
  def sign_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_user? user
    user && user == current_user
  end

  def signed_in?
    current_user.nil?
  end

  def is_admin?
    current_user.role == "admin"
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end

  def check_notification
    current_user.notifications.where(status: 0).any?
  end
end
