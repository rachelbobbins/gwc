class UsersController < ApplicationController
	def show
		@user = current_user
	end

	def edit
		@user = current_user
	end

	def update
		params.permit!

		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:notice] = "Successfully updated your account"
			redirect_to user_path(@user)
		else
			render "edit"
		end
	end
end