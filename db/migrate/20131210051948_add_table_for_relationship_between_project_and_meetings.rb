class AddTableForRelationshipBetweenProjectAndMeetings < ActiveRecord::Migration
  class Meeting < ActiveRecord::Base
  	has_and_belongs_to_many :projects
		belongs_to :project
  end
  
  class Project < ActiveRecord::Base
  end
  
  def up
  	create_table :meetings_projects, id: false, force: true do |t|
   	 	t.integer :project_id
   	 	t.integer :meeting_id
   	end

    Meeting.where('project_id IS NOT NULL').each do |m|
    	m.update_attributes(projects: [m.project])
  	end

  	remove_column :meetings, :project_id
  end

  def down
  	add_column :meetings, :project_id, :integer

  	drop_table :meetings_projects
  end
end
