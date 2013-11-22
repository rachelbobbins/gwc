require 'spec_helper'

describe "Authentication and permissions" do
	let(:meeting) { FactoryGirl.create :meeting, :with_project }
	let(:private_meeting) { FactoryGirl.create :meeting, is_private: true}
	let(:project) { meeting.project }
	let(:public_link) { project.links.first }
	let(:private_link) { FactoryGirl.create :link, is_private: true, name: "the private link" }
	
	before do
		private_link.update_attributes(owner: project)
	end


	context "an unauthenticated user" do
		it "cannot access the teacher portal" do
			visit "/teacher"
			page.should have_content "Sign in"
		end
		
		it "cannot view private links" do
			visit "/meetings/#{meeting.id}"

			page.should_not have_content public_link.name
			page.should_not have_content private_link.name
		end
		
		it "cannot view private classes" do
			visit "/meetings/#{private_meeting.id}"

			page.should have_content "Sign in"
		end
	end

	context "a logged-in student" do
		it "cannot access the teacher portal"
		it "cannot view private classes"
		it "can view private links"
	end
		

	context "a logged-in teacher" do
		it "can access the teacher portal"
		it "can view private links"
		it "can view private classes"
	end
end