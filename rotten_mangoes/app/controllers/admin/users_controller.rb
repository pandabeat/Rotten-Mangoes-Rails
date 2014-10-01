class Admin::UsersController < ApplicationController

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
      elsif @user.save && current_user.admin
        render :new, notice: "Record for #{@user.firstname} created successfully!"
      else
        redirect_to movies_path, notice: "Something weird happened after admin/create_new_user!"
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
			@user.destroy
  		redirect_to admin_users_path, notice: "User: #{@user.full_name} was deleted successfully"
  	end
  end

  protected
  def user_params
  	params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
