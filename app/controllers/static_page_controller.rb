class StaticPageController < ApplicationController
	def contact
		render "static/contact"
	end

	def  conduct
		render "static/conduct"
	end

	def home
		@meeting = Meeting.latest
		render "static/home"
	end

	def email_list
		students = User.students

		@active_students = students.select { |s| s.active }
		@dropout_students = students.select { |s| s.dropped_out }
		@inactive_students = students - @active_students - @dropout_students

		render "static/email_list"
	end

	def final_project
		render "static/final_project"
	end
end