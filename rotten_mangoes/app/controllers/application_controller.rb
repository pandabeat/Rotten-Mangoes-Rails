class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	protected

	def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorization
    unless current_user && current_user.admin
      flash[:error] = "You must be an admin."
      redirect_to :root
    end
  end

  # => Ransack search gem. Uncomment to use 
  # def search_params
  #   params[:q].try(:merge, m: 'or')
  # end


  helper_method :current_user, :authorization

end
