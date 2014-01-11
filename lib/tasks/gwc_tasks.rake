namespace :projects do
	desc "Export projects for spreadsheet" 
	task :print_for_spreadsheet => :environment do
		Project.find_each do |p|
			puts '*' * 80
			puts p.name
			
			User.all.each do |u|
				completed_projects = u.completed_projects.where(project: p)
				if completed_projects != []
					completed_projects.each do |cp|
						puts "#{u.first_name}, #{u.last_name}, 1, #{cp.url} "
					end
				else
					puts "#{u.first_name}, #{u.last_name}, 1, - "
				end
				
			end
		end
	end
end