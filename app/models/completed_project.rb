class CompletedProject < ActiveRecord::Base
	belongs_to :project
	
	has_and_belongs_to_many :users

	validate :url_is_okay

	private

	def url_is_okay
		unless url.match("https://www.khanacademy.org/cs")
			errors.add(:url, "is not a valid Khan Academy CS project")
		end
	end
end