require 'RMagick'

class ImageController < ApplicationController

	def index
	end
	
	def apply_filter
		content = params[:file_content][:content].read
		
		uuid = UUID.new
		generated_uuid = uuid.generate
		path = "/tmp" + "/" + generated_uuid
		
		Dir::mkdir(path)
		
		file_ext = File.extname(params[:file_content][:content].original_filename)
		
		File.open(path + "/file_name" + file_ext,"w") do |f|
			f.write(content.force_encoding("UTF-8"))
		end 		
		fullpath = path + "/file_name" + file_ext
		p "Before image magick:#{Time.now}"
		img = Magick::Image.read(fullpath).first
		result = img.posterize
		result.write(path + '/posterize.jpg')
		p "After image magick:#{Time.now}"
	end
end
