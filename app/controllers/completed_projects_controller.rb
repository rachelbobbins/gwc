class CompletedProjectsController < ApplicationController
	def new
		if current_user.student?
			@completed_project = CompletedProject.new
		else
			flash[:error] = "Teachers are not eligible to submit projects"
			redirect_to user_path(current_user)
		end
	end

	def create
		params.permit!
		users = [current_user, 
							User.find_by_id(params[:completed_project][:user1]), 
							User.find_by_id(params[:completed_project][:user2])]
							.compact
							.uniq

		@completed_project = CompletedProject.new(params[:completed_project])
		
		if @completed_project.save
			@completed_project.update_attributes!(users: users)
			flash[:notice] = "Congratulations on finshing a project!"
			redirect_to user_path(current_user)
		else
			flash[:error] = "Please correct the errors below"
			render "new"
		end
	end
end