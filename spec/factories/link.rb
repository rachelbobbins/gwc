FactoryGirl.define do
	factory :link do
		name							"A public link"
		url								"www.link.com"
		long_description 	"the number 1 link online"
		is_private				false
	end
end