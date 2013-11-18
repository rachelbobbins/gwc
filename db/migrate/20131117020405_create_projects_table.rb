class CreateProjectsTable < ActiveRecord::Migration
  def change
    create_table :projects do |t|
    	t.string :assignment_link

    	t.timestamps
    end
  end
end
