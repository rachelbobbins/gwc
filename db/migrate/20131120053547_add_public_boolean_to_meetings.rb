class AddPublicBooleanToMeetings < ActiveRecord::Migration
  def change
  	add_column :meetings, :is_private, :boolean, default: true
  end
end
