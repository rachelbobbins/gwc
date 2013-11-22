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
end