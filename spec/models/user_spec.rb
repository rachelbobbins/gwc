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

	describe ".all" do
		let!(:other) { FactoryGirl.create :user, last_name: "Allen"}
		let!(:alphabetical_users) { [other, user] }
		subject { User.all.to_a }
		
		it "uses last name for defaults sort order" do
			expect(subject).to eq(alphabetical_users)
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

	describe "#present_at_meeting" do
		let(:meeting) { FactoryGirl.create :meeting }
		let!(:record) { AttendanceRecord.create!(meeting: meeting, user: user) }

		it "returns true if the user was there" do
			expect(user.present_at_meeting(meeting)).to eq(true)
		end

		it "returns false if the user wasn't there" do
			absent_user = FactoryGirl.create :user

			expect(absent_user.present_at_meeting(meeting)).to eq(false)
		end
	end
end