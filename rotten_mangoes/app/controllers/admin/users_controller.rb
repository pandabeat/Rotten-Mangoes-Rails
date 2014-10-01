class Admin::UsersController < ApplicationController

before_filter :authorization

	def index
		@users = User.page(params[:page]).per(5)
	end

end
