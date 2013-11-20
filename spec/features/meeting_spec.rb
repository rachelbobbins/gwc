require 'spec_helper'

describe "finding out information about classes" do
	before :each do
		visit "/"

		within "#nav-menu" do
			click_link "Schedule"
		end
	end

	it "has a class schedule" do
		page.all(".meeting").count.should equal(2)

		within "#class0" do
			page.should have_content "Class 0"
			page.should have_content "Sat, Nov 16"
			page.should have_content "9am - 2pm"
		end
	end

	it "shows details link for public classes" do
		within "#class0" do
			page.should have_content "Details"
		end
	end

	it "hides details link for private classes" do
		within "#class1" do
			page.should_not have_content "Details"
		end
	end

end