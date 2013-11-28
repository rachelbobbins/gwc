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
		@completed_project = CompletedProject.new(params[:completed_project], users: [current_user])
		
		if @completed_project.save
			@completed_project.update_attributes(users: [current_user])
			flash[:notice] = "Congratulations on finshing a project!"
			redirect_to user_path(current_user)
		else
			flash[:error] = "Please correct the errors below"
			render "new"
		end
	end
end