require 'spec_helper'

describe CompletedProject do
	describe "validations" do
		it "must belong to at least 1 user"
		it "must belong to at least 1 project"
		it "must have a khan academy url" do
			completed_project = CompletedProject.create(url: 'foo.com')
			completed_project.errors[:url].should include("must start with https://www.khanacademy.org/cs")
		end

	describe ".to_csv" do
		let!(:user1) { FactoryGirl.create :user, last_name: 'Aaron' }
		let!(:user2) { FactoryGirl.create :user, last_name: 'Zeus' }
		let!(:project) { FactoryGirl.create :project, name: 'Project Awesome' }
		let(:project_url) { 'https://www.khanacademy.org/cs/fake' }
		before do
			CompletedProject.create(users: [user1], project: project, url: project_url)
		end

		it "returns a spreadsheet of projects per student" do
			parsed = CompletedProject.to_csv([user1, user2])

			header = parsed[0]
			expect(header[0]).to eq('Students')
			expect(header[1]).to eq('Project Awesome')

			row1 = parsed[1]
			expect(row2[0]).to eq(user1.name)
			expect(row2[1]).to eq(project_url)
			
			row2 = parsed[2]
			expect(row2[0]).to eq(user2.name)
			expect(row2[1]).to be_nil
		end
	end
	end
end