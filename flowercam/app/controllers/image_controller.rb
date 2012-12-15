require 'RMagick'

class ImageController < ApplicationController

	def index
	end
	
	def apply_filter
		content = params[:file_content][:content].read
		file_ext = File.extname(params[:file_content][:content].original_filename)
		
		uuid = UUID.new
		generated_uuid = uuid.generate
		@name_old = generated_uuid + file_ext
		@name_new = generated_uuid + "new" + file_ext
		
		path = Rails.root.to_s + "/public/images/" 
		
		@old_image_fullpath = path + generated_uuid + file_ext
		
		File.open(@old_image_fullpath,"w") do |f|
			f.write(content.force_encoding("UTF-8"))
		end 		
		
		@new_image_fullpath = path + @name_new
		
		img = Magick::Image.read(@old_image_fullpath).first
		result = img.posterize
		result.write(@new_image_fullpath)
	end
end
