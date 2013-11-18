class AddLinksTable < ActiveRecord::Migration
  def change
  	create_table :links do |t|
  		t.string :url
  		t.string :name
  		t.text :long_description
  		t.boolean :is_private, default: false
  		t.references :owner, polymorphic: true

  		t.timestamps
  	end
  end
end
