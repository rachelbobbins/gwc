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
		before do
			admin = FactoryGirl.create :user, role: 'teacher'
			login_as(admin)
		end
		
		describe "summary page" do	
			before do
				AttendanceRecord.create(user: user1, meeting: meeting1)
				AttendanceRecord.create(user: user2, meeting: meeting1)
				AttendanceRecord.create(user: user1, meeting: meeting2)

				page.click_link("Attendance")
			end

			it "has a header row with a list of dates" do
				headings = page.all('thead td').map(&:text)
				expect(headings[0]).to eq('Student')
				expect(headings[1]).to eq('Jan 01, 2014')
				expect(headings[2]).to eq('Jan 02, 2014')
			end

			it "has a footer row with total # of students present" do
				footers = page.all('tfoot td').map(&:text)
				expect(footers[0]).to eq('Total Students Present:')
				expect(footers[1]).to eq('2')
				expect(footers[2]).to eq('1')
			end

			it "shows a table of attendance records per student" do
				rows = page.all("table tr")
				expect(rows.count).to eq(2)

				first_row = rows.first.all('td').map(&:text)
				expect(first_row[0]).to eq(user1.name)
				expect(first_row[1]).to eq('Present')
				expect(first_row[2]).to eq('Present')

				second_row = rows.last.all('td').map(&:text)
				expect(second_row[0]).to eq(user2.name)
				expect(second_row[1]).to eq('Present')
				expect(second_row[2]).to eq('-')
			end
		end

		describe "attendance for a specific meeting" do
			before do
				AttendanceRecord.create(user: user1, meeting: meeting1) 
				visit meeting_attendance_path(meeting1)
			end

			it "shows which students were present" do
				heading = page.all('h3').first
				expect(heading.text).to include("Attendance for #{meeting1.starts_at.strftime('%b %d, %Y')}")
			
				first_row = page.all("table tr").first
				expect(first_row.text).to include('Present')
				expect(first_row.text).to include(user1.name)

				second_row = page.all("table tr").last
				expect(second_row.text).to include('--')
				expect(second_row.text).to include(user2.name)
			end

			it "allows user to edit attendance for a meeting" do
				click_link "Edit"

				user1_box = page.find("input#user_#{user1.id}")
				expect(user1_box).to be_checked
				page.uncheck("user_#{user1.id}")

				user2_box = page.find("input#user_#{user2.id}")
				expect(user2_box).not_to be_checked
				page.check("user_#{user2.id}")

				click_button("Save Attendance")

				first_row = page.all("table tr").first
				expect(first_row.text).to include('--')
				expect(first_row.text).to include(user1.name)

				second_row = page.all("table tr").last
				expect(second_row.text).to include('Present')
				expect(second_row.text).to include(user2.name)
			end
		end
	end
end