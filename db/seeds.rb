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

	Meeting.create(starts_at: starts_at, ends_at: ends_at)
end

create_meeting(11, 16, 2013, 9, 14)
create_meeting(11, 22, 2013, 19, 22)
create_meeting(12, 7,  2013)
create_meeting(12, 14,  2013)
create_meeting(1, 11,  2014)
create_meeting(1, 25,  2014)
create_meeting(2, 1,  2014)
create_meeting(2, 15,  2014)
create_meeting(3, 1,  2014)
create_meeting(3, 15,  2014)
create_meeting(4, 5,  2014)
create_meeting(4, 26,  2014)
create_meeting(5, 3,  2014)
create_meeting(5, 17,  2014)

