include ApplicationHelper

def signup_fill(user)
	
=begin
		fill_in "Name", with: user.name
		fill_in "Email", with: user.email
		fill_in "Password", with: user.password
		fill_in "Confirmation", with: user.password_confirmation

		fill_in "Name", with: "Example User"		
		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "foobar"
		fill_in "Confirmation", with: "foobar"
=end
		
		fill_in "Name", with: user.name
		fill_in "Email", with: "user@example.com"	#factoryGirlの設定がおかしい？
		fill_in "Password", with: user.password
		fill_in "Confirmation", with: user.password_confirmation
		
end

def user_update_fill(new_user)
		if new_user[:name]
			fill_in "Name", with: new_user[:name]
		else
			fill_in "Name", with: user.name
		end
		if new_user[:email]
			fill_in "Email", with: new_user[:email]
		else
			fill_in "Email", with: user.email
		end
		if new_user[:password]
			fill_in "Password", with: new_user[:password]
		else
			fill_in "Password", with: user.password
		end
		if new_user[:password_confirmation]
			fill_in "Confirmation", with: new_user[:password_confirmation]	
		else
			fill_in "Confirmation", with: user.password_confirmation
		end
end

def sign_in(user, options={})
	if options[:no_capybara]
			remember_token = User.new_remember_token
			cookies[:remember_token] = remember_token
			user.update_attribute(:remember_token, User.encrypt(remember_token))
		else
			visit signin_path
			fill_in "Email", with: user.email
			fill_in "Password", with: user.password
			click_button "Sign in"
	end
end