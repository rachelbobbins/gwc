class AddDescriptionToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :description, :text
  	add_column :projects, :rendered_description, :text
  end
end
