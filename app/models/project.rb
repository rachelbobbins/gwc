class Project < ActiveRecord::Base
	has_and_belongs_to_many :meetings

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
