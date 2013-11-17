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
end