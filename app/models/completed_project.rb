class CompletedProject < ActiveRecord::Base
	belongs_to :project

	attr_accessor :user1, :user2
	
	has_and_belongs_to_many :users

	validate :url_is_okay

	private

	def url_is_okay
		unless url.match("https://www.khanacademy.org/cs")
			errors.add(:url, "must start with https://www.khanacademy.org/cs")
		end
	end
end