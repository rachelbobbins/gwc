require 'spec_helper'

describe "Attendance Interface" do
	let!(:user1) { FactoryGirl.create :user, last_name: "Aaron" }
	let!(:user2) { FactoryGirl.create :user, last_name: "Zeus" }
	let(:meeting1) { FactoryGirl.create :meeting, starts_at: '2014-01-01'.to_date }
	let(:meeting2) { FactoryGirl.create :meeting, starts_at: '2014-01-02'.to_date }
			
	describe "permissions" do
		it "is not accesible to unathenticated users" do
			visit "/attendance"

			page.should have_content "Sign in"
		end

		it "is not accessible to students" do
			login_as(user1)

			visit "/attendance"
			expect(current_path).to eq('/user_root')
		end
	end

	describe "interface for teachers" do
		let(:dropout_user) { FactoryGirl.create :user, last_name: 'Middle' }
		
		before do
			admin = FactoryGirl.create :user, role: 'teacher'
			AttendanceRecord.create(user: user1, meeting: meeting1)
			AttendanceRecord.create(user: user1, meeting: meeting2)
			
			AttendanceRecord.create(user: user2, meeting: meeting1)
			AttendanceRecord.create(user: user2, meeting: meeting2)
			
			AttendanceRecord.create(user: dropout_user, meeting: meeting1)

			login_as(admin)
			page.click_link("Attendance")
		end


		it "has a header row with a chronological list of dates" do
			headings = page.all('thead th').map(&:text)
			expect(headings[0]).to eq('Student')
			expect(headings[1]).to eq('Jan 01, 2014')
			expect(headings[2]).to eq('Jan 02, 2014')
		end

		it "has a footer row with total # of students present" do
			footers = page.all('tfoot td').map(&:text)
			expect(footers[0]).to eq('Total Students Present:')
			expect(footers[1]).to eq('3')
			expect(footers[2]).to eq('2')
		end

		it "shows a table of attendance records per student" do
			rows = page.all("table tr")
			expect(rows.count).to eq(3)

			first_row = rows[0].all('td').map(&:text)
			expect(first_row[0]).to eq(user1.name)
			expect(first_row[1]).to eq('Present')
			expect(first_row[2]).to eq('Present')

			second_row = rows[1].all('td').map(&:text)
			expect(second_row[0]).to eq(dropout_user.name)
			expect(second_row[1]).to eq('Present')
			expect(second_row[2]).to eq('---')

			third_row = rows[2].all('td').map(&:text)
			expect(third_row[0]).to eq(user2.name)
			expect(third_row[1]).to eq('Present')
			expect(third_row[2]).to eq('Present')
		end

		it 'allows the teacher to ignore students who only showed up to the first meeting' do
			click_link("Exclude Dropouts")
			rows = page.all("table tr")
			
			expect(rows.count).to eq(2)
			expect(page.body).not_to include(dropout_user.name)
		end

		describe "attendance for a specific meeting" do
			before { page.click_link('Jan 02, 2014') }
			
			it "shows which students were present" do
				heading = page.all('h3').first
				expect(heading.text).to eq("Attendance for Jan 02, 2014")
			
				user1_box = page.find("input#user_#{user1.id}")
				expect(user1_box).to be_checked

				user2_box = page.find("input#user_#{user2.id}")
				expect(user2_box).to be_checked

				dropout_box = page.find("input#user_#{dropout_user.id}")
				expect(dropout_box).not_to be_checked
			end

			it "allows teacher to edit attendance" do
				page.uncheck("user_#{user1.id}")
				page.check("user_#{dropout_user.id}")

				click_button("Save Attendance")
				rows = page.all("table tr")
				
				first_row = rows[0].all('td').map(&:text)
				expect(first_row[2]).to eq('---')

				second_row = rows[1].all('td').map(&:text)
				expect(second_row[2]).to eq('Present')

				third_row = rows[2].all('td').map(&:text)
				expect(third_row[2]).to eq('Present')
			end
		end
	end
end