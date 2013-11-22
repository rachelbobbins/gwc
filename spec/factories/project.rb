FactoryGirl.define do
	factory :project do
		name 							"Drawing project"
		assignment_link 	"www.project.com"
		description				"You'll draw things"

		after(:create) do |project|
			FactoryGirl.create :link, owner: project
		end
	end
end