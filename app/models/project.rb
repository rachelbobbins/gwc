class Project < ActiveRecord::Base
	has_many :meetings
	has_many :links, as: :owner

	validates_presence_of :assignment_link, :name

	markdownize! :description

	rails_admin do
		edit do
			configure :rendered_description do
				hide
			end
		end
	end
end
