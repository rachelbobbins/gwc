require 'spec_helper'

describe CompletedProject do
	describe "validations" do
		it "must belong to at least 1 user"
		it "must belong to at least 1 project"
		it "must have a khan academy url" do
			completed_project = CompletedProject.create(url: 'foo.com')
			completed_project.errors[:url].should include("is not a valid Khan Academy CS project")
		end

	end
end