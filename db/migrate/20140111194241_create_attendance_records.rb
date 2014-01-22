class CreateAttendanceRecords < ActiveRecord::Migration
  def change
    create_table :attendance_records do |t|
    	t.integer :user_id
    	t.integer :meeting_id

    	t.timestamp
    end
  end
end