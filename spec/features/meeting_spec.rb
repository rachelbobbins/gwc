require 'spec_helper'

describe "finding out information about classes" do
	let!(:meeting1) { FactoryGirl.create :meeting, starts_at: DateTime.new(2013, 11, 16, 9) }
	let!(:meeting2) { FactoryGirl.create :meeting, starts_at: DateTime.new(2013, 11, 23, 9), is_private: true}
	let!(:admin) { FactoryGirl.create :user, role: 'teacher'}

	before do
		login_as(admin)

		visit "/"
		within "#nav-menu" do
			click_link "Schedule"
			click_link "Complete Schedule"
		end
	end

	describe "Meeting schedule" do
		it "shows date/time for each meeting" do
			page.all(".meeting").count.should equal(2)

			within "#class0" do
				page.should have_content "Class 0"
				page.should have_content "Sat, Nov 16"
				page.should have_content "9am - 12pm"
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

	describe "details page for a meeting with an associated project" do
		let(:meeting) { FactoryGirl.create :meeting, :with_project }
		let(:project) { meeting.projects.first }
		
		before do
			visit "/meetings/#{meeting.id}"
		end

		it "always includes the project's name, description and details link" do
			page.should have_content "| Details"
			page.should have_content project.name
			page.should have_content project.description
		end
		
		it "shows the meeting's description" do
			page.should have_content meeting.description
		end

	end

end