require 'spec_helper'

describe "Projects" do 
	let!(:project) { FactoryGirl.create :project }

	it "let's the user navigate to the page for a project" do
		visit "/"
		page.find("#nav-menu").click_link("#{project.name}")
		page.should have_content("#{project.description}")
	end

	describe "Gallery of completed projects" do
		let(:completed_project) { FactoryGirl.create :completed_project, project: project}
		let(:user1) { FactoryGirl.create :user }
		let(:user2) { FactoryGirl.create :user }
		
		before do
			completed_project.update_attributes(users: [user1, user2])
			visit "/projects/#{project.id}"
		end
		
		it "embeds Khan Academy's rendering for each project" do
			page.should have_content "Completed Project by #{user1.initials}, #{user2.initials}"
		end
		
	end

end