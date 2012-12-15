require 'RMagick'

class ImageController < ApplicationController

	def index
	end
	
	def apply_filter
		if params[:file_content] && params[:filter]
			img_res = Image.apply_filter(params[:file_content],params[:filter])
			@name_new = img_res.new_name
			@name_old = img_res.old_name
		else
			flash[:alert] = "You have to choose image and filter!"
			render :action=>"index"
		end
	end
end
