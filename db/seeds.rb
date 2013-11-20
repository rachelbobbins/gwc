# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_meeting(month, date, year, start_hour = nil, end_hour = nil )
	start_hour = start_hour != nil ? start_hour : 9
	end_hour = end_hour != nil ? end_hour : 13
	
	starts_at = DateTime.new(year, month, date, start_hour, 0, 0)
	ends_at = DateTime.new(year, month, date, end_hour, 0, 0)

	Meeting.create(starts_at: starts_at, ends_at: ends_at, description: "Foo")
end

meeting = create_meeting(11, 16, 2013, 9, 14)
meeting.update_attributes(is_public: true)
Meeting.all.first.update_attributes(description: """
Goals
=====
	* Students will be introduced to computer science and to real world examples.

Resources
=========
	* Introductory powerpoint
""")

create_meeting(11, 22, 2013, 19, 22)


User.create(email: 'rachelheidi@gmail.com', password: 'password1')
