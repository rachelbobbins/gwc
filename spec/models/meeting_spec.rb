require 'spec_helper'

describe Meeting do
	describe "validations" do
		it { should validate_presence_of :starts_at }
		it { should validate_presence_of :ends_at }
		it { should validate_presence_of :description }
	end

	describe "#projects" do
		let(:project1) { FactoryGirl.create :project }
		let(:project2) { FactoryGirl.create :project }
		let(:meeting) { FactoryGirl.create :meeting, projects: [project1, project2] }
		
		it "can have many projects" do
			meeting.projects.should include(project1)
			meeting.projects.should include(project2)
		end
	end
end