require 'spec_helper'

describe "finding out information about classes" do
	before do
		login_as_admin

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

	describe "details page for a meeting with an associated project" do
		let(:meeting) { FactoryGirl.create :meeting, :with_project }
		let(:project) { meeting.project }
		
		before do
			visit "/meetings/#{meeting.id}"
		end

		it "shows the project, and the project's description/links" do
			page.should have_content project.name
			page.should have_content project.description
			
			project.links.each { |link| page.should have_content link.name }
		end
		
		it "shows the meeting's links"
		it "shows the meeting's description" do
			page.should have_content meeting.description
		end

	end

end