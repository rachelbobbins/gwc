class CreateCompletedProjectTable < ActiveRecord::Migration
  def change
    create_table :completed_projects do |t|
    	t.integer :project_id
    	t.string  :url
    	t.timestamp
    end

    create_table :completed_projects_users, id: false do |t|
    	t.integer :user_id
    	t.integer :completed_project_id
    end
  end
end
