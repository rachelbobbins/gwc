class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :role, :inclusion => {:in => ['teacher', 'student']}

	validates_presence_of :first_name, :last_name
	has_and_belongs_to_many :completed_projects

	def self.students
		User.where(role: 'student')
	end

	def admin?
		role == 'teacher'
	end

	def student?
		role == 'student'
	end

	def name
		first_name + " " + last_name
	end

	def initials
		first_name[0] + last_name[0]
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
