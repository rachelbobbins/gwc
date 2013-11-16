class StaticPageController < ApplicationController
	def contact
		render "static/contact"
	end

	def schedule
		render "static/schedule"
	end
end