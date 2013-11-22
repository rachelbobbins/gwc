class AddDetailsToUserModel < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string, null: false, default: "Joe"
  	add_column :users, :last_name, :string, null: false, default: "Smith"
  	add_column :users, :grade, :integer
  end
end
