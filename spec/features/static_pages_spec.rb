require 'spec_helper'

describe "static pages" do
	before :each do
		visit "/"
	end

	it "has a contact info page" do
		within "#nav-menu" do
			click_link "Contact Us"
		end

		page.should have_content "rachelheidi+gwc@gmail.com"
		page.should have_content "embreinhardt@gmail.com"
	end
end