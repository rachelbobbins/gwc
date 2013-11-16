require 'spec_helper'

describe "Blog posts" do 
	before :each do
		Post.create(title: "Original Title", text: "I've got some text, dawg")

		visit "/"
	end

	it "shows existing posts on the homepage" do
		page.should have_content "Original Title"
	end

	it "lets the user create a blog post" do
		click_link "New Post"

		fill_in "Title", with: "Post Title"
		fill_in "Text", with: "Arbitrary Text"
		click_button "Create Post"

		page.should have_content "Arbitrary Text"
	end
end