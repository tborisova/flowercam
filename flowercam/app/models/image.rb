class Image
	def self.apply_filter img, filter
		path = write_content_to_file img
		
		apply_filter_pr path,filter
		
		ImageResult.new(@name_old,@name_new)
	end
	
	private
	
	def self.write_content_to_file img
		content = img[:content].read
		file_ext = File.extname(img[:content].original_filename)
		
		uuid = UUID.new
		generated_uuid = uuid.generate
		@name_old = generated_uuid + file_ext
		@name_new = generated_uuid + "new" + file_ext
		
		path = Rails.root.to_s + "/public/images/" 
		
		@old_image_fullpath = path + generated_uuid + file_ext
		
		File.open(@old_image_fullpath,"w") do |f|
			f.write(content.force_encoding("UTF-8"))
		end 		
		
		path
	end
	
	def self.apply_filter_pr path,filter
		new_image_fullpath = path + @name_new
		
		img = Magick::Image.read(@old_image_fullpath).first
		result = apply_filter_to_image img, filter
		result.write(new_image_fullpath)
	end
	
	def self.apply_filter_to_image img, filter
	 case filter
		when "posterize"  then img.posterize
		when "sepiatone"  then img.sepiatone
	 	when "shade"  then img.shade
	 	when "sharpen"  then img.sharpen
	 	when "sketch"  then img.sketch
	 	when "solarize"  then img.solarize
	 	when "vignette" then img.vignette
	 	when "wave" then img.wave
	 	when "wet_floor" then img.wet_floor
	 end
	
	end
end
