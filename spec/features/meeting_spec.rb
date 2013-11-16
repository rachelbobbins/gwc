require 'spec_helper'

describe "finding out information about classes" do
	before :each do
		visit "/"

		within "#nav-menu" do
			click_link "Schedule"
		end
	end

	it "has a class schedule" do
		page.all(".meeting").count.should equal(14)

		within "#class0" do
			page.should have_content "Class 0"
			page.should have_content "Sat, Nov 16"
			page.should have_content "9am - 2pm"
		end
	end

end