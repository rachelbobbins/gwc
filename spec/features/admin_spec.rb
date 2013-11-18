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
			pending
			within ".table" do
				click_link "Meetings"
			end

			page.all("tr .edit_member_link a").first.click

			within "#meeting_project_id_field" do
				page.find(".create").click
			end

			within "#modal" do
				fill_in "Assignment link", with: "www.google.com"
				fill_in "Name", with: "Google"
				click_link ".save-action"
			end

			within "#meeting_project_id" do
				page should have_content "Fake name"
			end
		end
	end
end