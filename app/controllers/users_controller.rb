class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index, :edit, :update]
	before_action :correct_user, only: [:edit, :update]
	
	def index
		@users = User.all
	end
	
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			flash.now[:error] = "Invalid email or password combination"
			render 'new'
		end
	end
	
	def edit
	end
	
	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end
	
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		
		def signed_in_user
			unless signed_in? then
				store_location
				flash[:notice] = "Please sing in."
				redirect_to signin_url
			end
		end
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
end
