class AddColumnForLinkPriority < ActiveRecord::Migration
  def change
  	add_column :links, :priority, :integer, allow_nil: false
  end
end
