class CreateRenderedDescriptionColumnOnMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :rendered_description, :text
  end
end
