require 'pry'
class Admin::UsersController < Admin::BaseController

 before_filter :authorization

	def index
		@users = User.page(params[:page]).per(5)
	end

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)

  	if @user.save && !current_user 
  		  session[:user_id] = @user.id # auto log in
  		  redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
      elsif @user.save && @current_user.admin
        redirect_to admin_users_path, notice: "Record for #{@user.firstname} created successfully!"
      else
        redirect_to admin_users_path, notice: "Something weird happened after admin/create_new_user!"
      end
  end

  def update
    @user = User.find(params[:id])
    
  	if @user.update_attributes(user_params)
  		redirect_to admin_users_path, notice: "#{@user.full_name} was updated successfully!"
  	else
  		render :edit
  	end
  end

  def destroy
  	@user = User.find(params[:id])
  	if @user.id == current_user.id
  		redirect_to admin_users_path, notice: "You cannot delete yourself."
  	else
      # => send an email notification to user
      UserMailer.notify_delete_email(@user).deliver
			@user.destroy
  		redirect_to admin_users_path, notice: "User: #{@user.full_name} was deleted successfully"
  	end
  end

  # =>  PUT /admin/users/:user/switch_back
   def switch_back
    flash.keep[:notice] = "You are no longer ghost viewing #{current_user.full_name}\'s account"
    session[:user_id] = session[:actual_user_id]
    session[:actual_user_id] = nil
    redirect_to admin_users_path
  end

  # =>  PUT /admin/users/:user_id/switch
  def switch
    if !ghost?
      @user = User.where(admin: [false, nil]).find(params[:id])
      session[:actual_user_id] = current_user.id
      session[:user_id] = @user.id
      redirect_to :back, notice: "You are now ghost viewing #{@user.full_name}\'s account"
    else
      redirect_to :back, notice: "You are already in ghost view. Currently viewing #{@user.full_name}\'s account"
    end
  end

  protected
  def user_params
  	params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
