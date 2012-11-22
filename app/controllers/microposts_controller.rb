class MicropostsController < ApplicationController
	before_filter :signed_in_user
	before_filter :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to '/'
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end
	def destroy
		@micropost.destroy
		redirect_to '/'
	end

	private

	def correct_user
	@micropost = Micropost.find_by_id(params[:id])
redirect_to root_url unless current_user?(@micropost.user)
	end


end
