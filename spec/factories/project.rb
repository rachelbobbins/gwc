FactoryGirl.define do
	factory :project do
		name 							"Drawing project"
		assignment_link 	"www.project.com"

		after(:create) do |project|
			FactoryGirl.create :link, owner: project
		end
	end
end