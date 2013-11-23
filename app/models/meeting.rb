class Meeting < ActiveRecord::Base
	belongs_to :project

	validates_presence_of :starts_at, :ends_at, :description
	
	markdownize! :description

	scope :by_date, -> { order(:starts_at)}


	def self.latest
		Meeting.by_date.where('starts_at < ?', DateTime.now).last
	end

	def self.up_to_now
		Meeting.by_date.where('starts_at < ?', DateTime.now + 6.hours)
	end

	def ordinal
		Meeting.all.sort_by(&:starts_at).index(self)
	end

	rails_admin do
		list do
			field :project
			field :starts_at
		end

		edit do
			configure :rendered_description do
				hide
			end
		end
	end
end
