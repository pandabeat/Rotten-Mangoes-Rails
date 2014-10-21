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
    unless admin? || ghost? 
      flash[:error] = "You must be an admin."
      redirect_to :root
    end
  end

  # => Ransack search gem. Uncomment to use 
  # def search_params
  #   params[:q].try(:merge, m: 'or')
  # end


  def admin?
    current_user.admin?
  end

  # => if there is a persisted user logged in (admin) that is viewing as another account user
  def ghost?
    actual_user.present?
  end
 
  # => when an admin switches to a reguar account (ghost view), admin remains the actual persisted user
  def actual_user
    @actual_user ||= User.where(admin: true).find_by(id: session[:actual_user_id]) if session[:actual_user_id]
  end

  helper_method :current_user, :admin?, :ghost?, :actual_user


end
