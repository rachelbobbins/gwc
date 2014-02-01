class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

	validates :role, :inclusion => {:in => ['teacher', 'student']}

	validates_presence_of :first_name, :last_name
	has_and_belongs_to_many :completed_projects
	has_many :attendance_records
	has_many :meetings_attended, through: :attendance_records, source: 'meeting'

	default_scope { order('last_name ASC') }
	
	def self.students
		User.where(role: 'student')
	end

	def admin?
		role == 'teacher'
	end

	def student?
		role == 'student'
	end

	def urls_for_project(project)
		# begin
			completed_projects.where(project: project).map(&:url)
		# rescue
		# 	''
		# end
	end

	def name
		first_name + " " + last_name
	end

	def initials
		first_name[0] + last_name[0]
	end

	def present_at_meeting(meeting)
		attendance_records.where(meeting: meeting).count == 1
	end

	def present_at_percent_of_meetings(p)
		n_meetings = Meeting.up_to_now.count
		min_number = p * n_meetings

		meetings_attended.count >= min_number
	end

	def active
		return false if dropped_out
		return meetings_attended.count > 1 || Meeting.up_to_now.count <= 1
	end

	rails_admin do
		object_label_method do
			:name
		end
		list do
			field :role
			field :email
			field :first_name
			field :last_name
			field :grade
		end
	end
end
