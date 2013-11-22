class MeetingsController < ApplicationController
	def index
		@meetings = Meeting.by_date
	end

	def show
		@meeting = Meeting.find(params[:id])
		
		authorize! :read, @meeting
	end
end