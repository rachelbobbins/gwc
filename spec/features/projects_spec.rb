require 'spec_helper'

describe "Projects" do 
	let!(:project) { FactoryGirl.create :project }
	let(:completed_project) { FactoryGirl.create :completed_project, project: project}
	let(:user1) { FactoryGirl.create :user }
	let(:user2) { FactoryGirl.create :user }

	it "let's the user navigate to the page for a project" do
		visit "/"
		page.find("#nav-menu").click_link("#{project.name}")
		page.should have_content("#{project.description}")
	end

	describe "Gallery of completed projects" do
		before do
			completed_project.update_attributes(users: [user1, user2])
			visit "/projects/#{project.id}"
		end
		
		it "embeds Khan Academy's rendering for each project" do
			page.should have_content "Completed Project by #{user1.initials}, #{user2.initials}"
		end
	end

	describe "Submitting a Project" do
		it "is not available for unauthenticated users" do
			visit "/"
			
			page.should_not have_content "Submit a Project"
		end

		it "is not available for teachers" do
			login_as_admin
			click_link "Submit a Project"

			page.should have_content "Teachers are not eligible to submit project"
		end

		context "an authenticated student" do
			before do
				login_as user1
				click_link "Submit a Project"
			end

			it "can submit a project without any teammates" do
				fill_in "Link", with: "http://www.khanacademy.com/cs/fake-project"
				select project.name, from: "Which project?"

				click_button "Submit Project"
				page.should have_content "Congratulations on finshing a project!"
				user1.completed_projects.count.should == 1
			end

		end


	end

end