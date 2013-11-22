FactoryGirl.define do
	factory :meeting do
		starts_at 	DateTime.new(2014, 1, 1, 9, 0, 0)
		ends_at 		DateTime.new(2014, 1, 1, 12, 0, 0)
		description "First class of 2014"
		is_private 	false

		trait :with_project do
			project { FactoryGirl.create :project }
		end
	end
end