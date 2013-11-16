class Meeting < ActiveRecord::Base
	markdownize! :description

	scope :by_date, -> { order(:starts_at)}
	def ordinal
		Meeting.all.sort_by(&:starts_at).index(self)
	end
end
