class Meeting < ActiveRecord::Base
	has_and_belongs_to_many :projects

	has_many :attendance_records
	has_many :students_present, through: :attendance_records, source: 'user'

	validates_presence_of :starts_at, :ends_at, :description
	
	markdownize! :description

	scope :by_date, -> { order(:starts_at) }


	def self.latest
		Meeting.by_date.where('starts_at < ?', DateTime.now).last
	end

	def self.up_to_now
		Meeting.by_date.where('starts_at < ?', DateTime.now + 6.hours)
	end

	def ordinal
		Meeting.all.sort_by(&:starts_at).index(self)
	end

	def name
		starts_at.to_s
	end

	rails_admin do
		list do
			field :ordinal
			field :projects
			field :starts_at
		end

		edit do
			configure :rendered_description do
				hide
			end
		end
	end
end
