class StaticPageController < ApplicationController
	def contact
		render "static/contact"
	end

	def  conduct
		render "static/conduct"
	end
end