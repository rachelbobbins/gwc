class AddDropOutColumnToUser < ActiveRecord::Migration
  def change
  	add_column :users, :dropped_out, :boolean, default: false
  end
end
