class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_host
    @current_host= session[:host_id]
  end

  def logged_in?
    current_host.present?
  end

  helper_method :current_host, :logged_in?
end
