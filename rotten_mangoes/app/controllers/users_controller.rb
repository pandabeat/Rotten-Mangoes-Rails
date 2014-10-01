class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
      if !current_user
  		  session[:user_id] = @user.id # auto log in
  		  redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
      elsif current_user.admin
        redirect_to admin_users_path, notice: "Record for #{@user.firstname} created successfully!"
      else
        redirect_to movies_path, notice: "Something weird happened after admin/create_new_user!"
      end

  	else
  		flash.now[:alert] = "Log in failed..."
  		render :new
  	end
  end

  # def edit
  #   @user = User.find(params[:id])
  # end

  # ----



  # ----


  protected
  def user_params
  	params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end
end
