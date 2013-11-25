FactoryGirl.define do
	factory :user do
		first_name "John"
		last_name "User"
		email { Faker::Internet.email }
		password "password"
		role "student"
	end
end