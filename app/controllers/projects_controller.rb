class ProjectsController < ApplicationController
	def show
		@project = Project.find(params[:id])
		@completed_projects = CompletedProject.where(project: @project)
	end


end