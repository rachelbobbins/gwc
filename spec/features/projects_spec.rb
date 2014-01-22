require 'spec_helper'

describe "Projects" do 
	let!(:project) { FactoryGirl.create :project }
	let(:completed_project) { FactoryGirl.create :completed_project, project: project}
	let(:user1) { FactoryGirl.create :user,  last_name: 'Aaron' }
	let!(:user2) { FactoryGirl.create :user, last_name: 'Baron' }
	let!(:admin) { FactoryGirl.create :user, role: 'teacher' }

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
			login_as(admin)
			visit "/"
			click_link "Submit a Project"

			page.should have_content "Teachers are not eligible to submit project"
		end

		context "an authenticated student" do
			let(:fake_url) { "https://www.khanacademy.org/cs/fake-project" }
			
			before do
				login_as user1
				click_link "Submit a Project"
			end

			it "can submit a project without any teammates" do
				fill_in "Link", with: fake_url
				select project.name, from: "Which project?"

				click_button "Submit Project"
				page.should have_content "Congratulations on finshing a project!"
				user1.completed_projects.count.should == 1
			end

			it "can submit a project with teammates" do
				fill_in "Link", with: fake_url
				select project.name, from: "Which project?"
				select user2.name, from: "Teammate 1"

				click_button "Submit Project"
				page.should have_content "Congratulations on finshing a project!"
				user1.completed_projects.count.should == 1
				user2.completed_projects.count.should == 1
			end

			it "cannot submit a project that's not Khan Academy" do
				fill_in "Link", with: "http://foo.com"
				select project.name, from: "Which project?"
				click_button "Submit Project"

				page.should have_content "must start with https://www.khanacademy.org/cs"
			end

		end


	end

end