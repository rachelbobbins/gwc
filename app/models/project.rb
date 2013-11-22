class Project < ActiveRecord::Base
	has_many :meetings
	has_many :links, as: :owner

	validates_presence_of :assignment_link, :name

	markdownize! :description
end
