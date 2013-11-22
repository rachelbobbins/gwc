def login_as_admin
	visit new_user_session_path
	fill_in "Email", with: "rachelheidi@gmail.com"
	fill_in "Password", with: "password1"
	click_button "Sign in"
end