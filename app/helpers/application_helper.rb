module ApplicationHelper
	def disabled_link(text)
		link_to(text, "#", class: 'disabled')
	end
end
