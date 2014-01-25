class AttendancesController < ApplicationController
	before_filter :admin_user

	def index
		@include_dropouts = params[:include_dropouts] == 'false' ? false : true
		@meetings = Meeting.by_date
		@attendance_records = AttendanceRecord.all
		
		if @include_dropouts
			@users = User.students 
		else
			first_meeting_attendees = @attendance_records.where(meeting: @meetings.first).map(&:user)
			other_meeting_attendees = @attendance_records.where(meeting_id: @meetings[1..-1].map(&:id)).map(&:user)

			dropouts = first_meeting_attendees - other_meeting_attendees
			@users = User.students - dropouts
		end
	end

	def edit
		@users = User.students 
		@meeting = Meeting.find(params[:meeting_id])
	end

	def update
		meeting = Meeting.find(params[:meeting_id])
		AttendanceRecord.destroy_all(meeting: meeting)
		
		params[:user].keys.map do |user_id|
			AttendanceRecord.create(user_id: user_id, meeting: meeting)
		end
		
		redirect_to attendance_path(params[:meeting_id])
	end

	private

	def admin_user
		if current_user && !current_user.admin?
			redirect_to user_root_path
		elsif current_user == nil
			redirect_to new_user_session_path
		end
	end
end