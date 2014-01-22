class AttendancesController < ApplicationController
	before_filter :admin_user

	def index
		@users = User.students 
		@meetings = Meeting.by_date
		@attendance_records = AttendanceRecord.all
	end
	
	def show
		@users = User.students
		@meeting = Meeting.find(params[:meeting_id])
		@attendance_records = AttendanceRecord.where(meeting: @meeting)
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
		
		redirect_to meeting_attendance_path(params[:meeting_id])
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