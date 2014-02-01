class CompletedProject < ActiveRecord::Base
	belongs_to :project

	attr_accessor :user1, :user2
	
	has_and_belongs_to_many :users

	validate :url_is_okay
	
	def self.to_csv(students)
		projects = Project.all
		headers = ['Students'] + projects.map(&:name)

		CSV.generate do |csv|
			csv << headers
			students.each do |s|
				completed_projects = projects.map { |p| s.urls_for_project(p) }

				csv << [s.name] + completed_projects
			end
		end
	end

	private

	def url_is_okay
		unless url.match("https://www.khanacademy.org/cs")
			errors.add(:url, "must start with https://www.khanacademy.org/cs")
		end
	end
end