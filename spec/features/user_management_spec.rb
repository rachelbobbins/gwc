require 'spec_helper'

describe "Authentication and permissions" do
	let(:meeting) { FactoryGirl.create :meeting, :with_project }
	let(:private_meeting) { FactoryGirl.create :meeting, is_private: true}
	let(:project) { meeting.projects.first }

	context "an unauthenticated user" do
		it "cannot access the teacher portal - prompted to log in" do
			visit "/teacher"
			page.should have_content "Sign in"
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
		let!(:student) { FactoryGirl.create :user, role: 'student'}
		before { login_as student }
		
		it "cannot access the teacher portal" do
			visit "/teacher"
			page.should have_content "You are not an admin"
		end

		it "cannot view private classes - redirected to own account" do
			visit "/meetings/#{private_meeting.id}"

			page.should have_content "#{student.name}'s Account"
		end

		it "sees a sign out link" do
			within "#header" do
				page.should have_content "Log out"
			end
		end
	end
		

	context "a logged-in teacher" do
		let!(:admin) { FactoryGirl.create(:user, role: 'teacher') }

		before { login_as(admin) }
		
		it "can access the teacher portal" do
			visit "/teacher"
			page.should have_content "Site administration"
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

		it "can edit her name/grade" do
			page.find_link("Edit").click

			fill_in "Grade", with: '10'
			fill_in "First name", with: "Jolly"
			fill_in "Last name", with: "Roger"

			page.find_button("Update My Account").click
			page.should have_content "Successfully updated"
			page.should have_content "Jolly Roger's Account"
		end 
	end
end