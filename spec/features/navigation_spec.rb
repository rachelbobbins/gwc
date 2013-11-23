require 'spec_helper'

describe "static pages" do
	let!(:past_class) { FactoryGirl.create :meeting, :with_project, starts_at: DateTime.new(2001, 1, 1)}
	let!(:future_class) { FactoryGirl.create :meeting, :with_project, starts_at: DateTime.new(3001, 1, 1)}
	let!(:current_class) { FactoryGirl.create :meeting, starts_at: DateTime.now }

	before :each do
		current_class.update_attributes(project: future_class.project)
		login_as_student
		visit "/"
	end

	it "has a contact info page" do
		within "#nav-menu" do
			click_link "Contact Us"
		end

		page.should have_content "rachelheidi+gwc@gmail.com"
		page.should have_content "embreinhardt@gmail.com"
	end

	it "has a code of conduct page" do
		within "#nav-menu" do
			click_link "Contact Us"
		end

		page.should have_content "Code of Conduct"
	end


	it "has links to each class that's happened already" do
		within "#nav-menu" do
			page.should have_content "Class ##{past_class.ordinal}"
			page.should have_content "Class ##{current_class.ordinal}"
			page.should_not have_content "Class ##{future_class.ordinal}"
		end
	end

	it "has a homepage" do
		page.should have_content "This is the homepage"
	end
end