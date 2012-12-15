class ImageResult
	attr_reader :old_name, :new_name
	
	def initialize old, new
		@old_name = old
		@new_name = new
	end
end
