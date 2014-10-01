class Admin::UsersController < ApplicationController

before_filter :authorization
# before_action 

	def index
		@users = User.all
	end

end
