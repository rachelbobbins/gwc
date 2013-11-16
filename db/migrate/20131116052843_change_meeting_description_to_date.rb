class ChangeMeetingDescriptionToDate < ActiveRecord::Migration
  def self.up
  	change_column :meetings, :description, :text
	end

	def self.down
		raise ActiveRecord::IrreversibleMigration
	end
end
