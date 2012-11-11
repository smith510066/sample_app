module ApplicationHelper
	def full_title(page_title)
		base_title = "ruby on rails demo";
		if page_title.empty?
			page_title = base_title
		else
			"#{base_title} #{page_title}"
		end
	end

	def test_function
		
	end
end
