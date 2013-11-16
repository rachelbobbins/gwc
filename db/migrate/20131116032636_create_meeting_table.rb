class CreateMeetingTable < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
    	t.datetime :starts_at
    	t.datetime :ends_at
    	t.datetime :description

    	t.timestamps
    end
  end
end
