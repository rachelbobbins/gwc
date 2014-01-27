require 'spec_helper'

describe "Admin(teacher) interface" do
	let!(:admin) { FactoryGirl.create(:user, role: 'teacher', password: 'password') }
	describe "an unauthenticated user" do
		before { visit "/teacher" }
		
		it "asks for authentication" do
			page.should have_content "Sign in"
		end
	end

	describe "an authenticated user" do
		before { login_as(admin) }

		it "can create projects" do
			visit "/teacher/project"

			click_link "Add new"
			fill_in "Assignment link", with: "http://www.google.com"
			fill_in "Name", with: "Project 1 - Drawing Pictures"
			click_button "Save"

			page.should have_content "Project successfully created"
		end

		describe "emailing students" do
			let!(:user) { FactoryGirl.create :user, first_name: 'Jane', last_name: 'Doe', email: 'jdoe@fake.com' }
			it "can view a list of student emails, sorted by active status" do
				click_link "Email Students"

				page.should have_content "Active students (not dropped out; attended > 1 meeting)"
				page.should have_content "Inactive students (not dropped out; attended only 1 meeting)"
				page.should have_content "Dropout students (informed us they could not attend)" 
				page.should have_content "Jane Doe <jdoe@fake.com>"
			end
		end

		describe "managing meetings" do
			it "can create meetings" do
				visit "/teacher/meeting"
				
				click_link "Add new"
				fill_in "Starts at", with: "November 1, 2013"
				fill_in "Ends at", with: "November 1, 2013"
				fill_in "Description", with: "Hello, class"
				click_button "Save"
				
				page.should have_content "Meeting successfully created"
			end
		end
	end
end