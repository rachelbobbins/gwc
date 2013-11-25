require 'spec_helper'

describe "Authentication and permissions" do
	let(:meeting) { FactoryGirl.create :meeting, :with_project }
	let(:private_meeting) { FactoryGirl.create :meeting, is_private: true}
	let(:project) { meeting.project }
	let!(:public_link) { project.links.first }
	let(:private_link) { FactoryGirl.create :link, is_private: true, name: "the private link" }
	
	before do
		private_link.update_attributes(owner: project)
	end

	context "an unauthenticated user" do
		it "cannot access the teacher portal - prompted to log in" do
			visit "/teacher"
			page.should have_content "Sign in"
		end
		
		it "cannot view private links" do
			visit "/meetings/#{meeting.id}"

			page.should have_content public_link.name
			page.find_link(private_link.name)[:href].should == "#"
		end
		
		it "cannot view private classes" do
			visit "/meetings/#{private_meeting.id}"

			within "#main" do
				page.should have_content "Sign in"
			end
		end

		it "cannot view the Details link for a project" do
			visit "/meetings/#{meeting.id}"

			within ".project-section h2" do
				page.all("a.disabled").count.should equal(1)
			end
		end

		it "sees a login link" do
			visit "/"
			within "#header" do
			  page.should have_content "Log In"
			end
		end
	end

	context "a logged-in student" do
		before { login_as_student }
		
		it "cannot access the teacher portal" do
			visit "/teacher"
			page.should have_content "This is the homepage"
		end

		it "can view private links" do
			visit "/meetings/#{meeting.id}"

			page.should have_content public_link.name
			page.should have_content private_link.name
		end

		it "cannot view private classes - redirected to homepage" do
			visit "/meetings/#{private_meeting.id}"

			page.should have_content "This is the homepage"
		end

		it "sees a sign out link" do
			within "#header" do
				page.should have_content "Log out"
			end
		end
	end
		

	context "a logged-in teacher" do
		before { login_as_admin }
		it "can access the teacher portal" do
			visit "/teacher"
			page.should have_content "Site administration"
		end
		
		it "can view private links" do
			visit meeting_path(meeting)
			page.find_link(private_link.name)[:href].should == private_link.url
		end
		
		it "can view private classes" do
			visit meeting_path(private_meeting)
			page.should have_content(private_meeting.description)
		end
	end

	describe "managing an account" do
		let!(:user) { FactoryGirl.create :user, first_name: "Jane", last_name: "Smith" }
		let!(:completed_project) { FactoryGirl.create :completed_project, users: [user] }

		before do
		 login_as user
		 	within "#header" do
				page.find_link("My Account").click
			end
		end

		it "can view her profile" do
			page.should have_content "Jane Smith"
			page.should have_content user.email
		end

		it "can change her password" do
			page.find_link("Change Password").click
			fill_in "Password", with: 'new.password'
			fill_in "Password confirmation", with: 'new.password'
			fill_in "Current password", with: 'password'
			page.find_button("Update").click
			page.should have_content("Jane Smith's Account")
		end

		it "shows a list of her projects" do
			page.should have_content "My Completed Projects"
			page.should have_content completed_project.project.name
		end
	end
end