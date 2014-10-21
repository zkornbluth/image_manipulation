require 'rubygems'
require 'RMagick'

include Magick

class ImageRow < Magick::Image::View::Rows
	def initialize(image, row)
		@image = image
		@row = row
	end

	def each
		@image.columns.times do |j|
			yield @row[j]
		end
	end
end

class ImageArray
	include Enumerable

	def initialize(file_path)
		@image = ImageList.new(file_path)
		@view = @image.view(0, 0, @image.columns, @image.rows)
	end

	def columns
		@image.columns
	end

	def rows
		@image.rows
	end

	def max_intensity
		QuantumRange
	end

	def [](i)
		@view[i]
	end

	def []=(i, value)
		@view[i] = value
	end

	def each
		@image.rows.times do |i|
			yield ImageRow.new(@image, @view[i])
		end
	end

	def write(file_path)
		@view.sync
		@image.write(file_path)
	end
end

# SAMPLE CODE
# -----------
#
#image_array = ImageArray.new "cheetah_old.jpg"

#image_array.each do |pixel_row|
#	pixel_row.each do |pixel|
#		pixel.green = image_array.max_intensity
#		pixel.red = image_array.max_intensity
#		possible_blue = pixel.blue*10
#		pixel.blue = (possible_blue > image_array.max_intensity ? image_array.max_intensity : possible_blue)
#	end
#end

#image_array.write "cheetah_new.jpg"
#
# -----------
# REMEMBER, DON'T WRITE YOUR CODE IN THIS FILE
