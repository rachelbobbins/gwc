FactoryGirl.define do
	factory :project do
		name 							"Drawing project"
		assignment_link 	"www.project.com"
		description				"You'll draw things"
	end

	factory :completed_project do
		project { FactoryGirl.create :project }
		url "https://www.khanacademy.org/cs/fake-completed-project"
	end
end