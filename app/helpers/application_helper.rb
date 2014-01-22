module ApplicationHelper
	def disabled_link(text)
		link_to(text, "#", class: 'disabled')
	end

	def attendance_text(user: nil, attendance_records: nil)
		attendance_records.where(user: user).count > 0 ? 'Present' : '---'
	end
end
