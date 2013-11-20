require 'spec_helper'

describe "Admin(teacher) interface" do
	describe "an unauthenticated user" do
		before { visit "/teacher" }
		
		it "asks for authentication" do
			page.should have_content "Sign in"
		end
	end

	describe "an authenticated user" do
		before do
			visit "/teacher"
			fill_in "Email", with: "rachelheidi@gmail.com"
			fill_in "Password", with: "password1"
			click_button "Sign in"
		end

		it "can create projects" do
			within ".table" do
				click_link "Projects"
			end
			click_link "Add new"
			fill_in "Assignment link", with: "http://www.google.com"
			fill_in "Name", with: "Project 1 - Drawing Pictures"
			click_button "Save"

			page.should have_content "Project successfully created"
		end

		it "can associate a project(s) with a meeting", :js => true do
			pending "TODO: why can't rspec find save action?"
			within ".table" do
				click_link "Meetings"
			end

			sleep(2)

			page.all("tr .edit_member_link a").first.click

			within "#meeting_project_id_field" do
				page.find(".create").click
			end

			within "#modal" do
				fill_in "Assignment link", with: "www.google.com"
				fill_in "Name", with: "Google"
				page.find("a.save-action").click
			end

			within "#meeting_project_id" do
				page should have_content "Fake name"
			end
		end

		describe "managing meetings" do
			it "can create meetings" do
				within ".table" do
					click_link "Meetings"
				end

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