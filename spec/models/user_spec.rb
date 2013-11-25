require 'spec_helper'

describe User do
	let(:user) { FactoryGirl.create :user, first_name: "Jane", last_name: "Smith"}

	describe "validations" do
		it { should ensure_inclusion_of(:role).in_array(['teacher', 'student']) }
		it { should validate_presence_of(:first_name) }
		it { should validate_presence_of(:last_name) }
	end

	describe "#completed_projects" do
		let(:project1) { FactoryGirl.create :completed_project }
		let(:project2) { FactoryGirl.create :completed_project }

		before do
			user.update_attributes(completed_projects: [project1, project2])
		end
		
		it "has many completed projects" do
			user.completed_projects.should include(project1)
			user.completed_projects.should include(project2)
		end
	end

	describe "#initials" do
		subject { user.initials }
		it { should == "JS" }
	end

	describe "#name" do
		subject { user.name }
		it { should == "Jane Smith"}
	end
end