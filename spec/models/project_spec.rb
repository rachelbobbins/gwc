require 'spec_helper'

describe Project do
	describe ".validations" do
		it { should validate_presence_of :assignment_link }
		it { should validate_presence_of :name }
	end

	describe "#description" do
		let(:project) { FactoryGirl.create :project }
		
		it "automatically updates rendered_description when edited" do
			project.update_attributes(description: "#a header")
			expect(project.rendered_description).to eq("<h1>a header</h1>\n")
		end
	end

	describe "#meetings" do
		let(:project) { FactoryGirl.create :project }
		let(:meeting1) { FactoryGirl.create :meeting }
		let(:meeting2) { FactoryGirl.create :meeting }

		before { project.update_attributes(meetings: [meeting1, meeting2])}
		
		it "can have many meetings" do
			project.meetings.should include(meeting1)
			project.meetings.should include(meeting2)
		end
	end
end