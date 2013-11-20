class AddPublicBooleanToMeetings < ActiveRecord::Migration
  def change
  	add_column :meetings, :is_public, :boolean, default: false
  end
end
