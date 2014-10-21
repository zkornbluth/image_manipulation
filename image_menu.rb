require "./image_array.rb"
puts " "
puts "What file would you like to use?"
file_path = gets.chomp
puts " "
# open an image array at the given file path
img = ImageArray.new(file_path)
	
puts "What effect would you like to use?"
puts "Type b for black/white"
puts "Type t for tint"
puts "Type n for photonegative"
puts "Type h for horizontal reflection"
puts "Type q to quit."
effect = gets.chomp.downcase
puts " "
full_name_effect = ""
while effect != "q"
	if effect == "b"
		puts "This makes the image black and white."
		img.each do |row|
	        	row.each do |pixel|
	                	pixel_gray = (pixel.red + pixel.blue + pixel.green)/3
	                	pixel.red = pixel_gray
	                	pixel.blue = pixel_gray
	        	        pixel.green = pixel_gray
	        	end
		end
#-----------------------------------------------------------------------
	elsif effect == "n"
		puts "This makes the image a photonegative."
		img.each do |row|
	        	row.each do |pixel|
	                	pixel.red = img.max_intensity - pixel.red
	                	pixel.green = img.max_intensity - pixel.green
	                	pixel.blue = img.max_intensity - pixel.blue
	        	end
		end
#-----------------------------------------------------------------------
	elsif effect == "t"
		puts "This tints the image to the color of your choice."
		puts " "
		puts "What color would you like to tint to?"
		puts "Type r for red"
		puts "Type o for orange"
		puts "Type y for yellow"
		puts "Type g for green"
		puts "Type b for blue"
		puts "Type p for purple"
		tint_type = gets.chomp.downcase
		name_effect = "#{tint_type}_tint"
	
		def tint_blue(pixel)
	        	pixel.red = 0
	        	pixel.green = 0
		end
	
		def tint_red(pixel)
	        	pixel.green = 0
	        	pixel.blue = 0
		end
	
		def tint_green(pixel)
	        	pixel.red = 0
	        	pixel.blue = 0
		end
		
		def tint_orange(pixel)
			pixel.blue = 0
			pixel.green = pixel.green / 2
		end
	
		def tint_yellow(pixel)
			pixel.blue = 0
		end
	
		def tint_purple(pixel)
			pixel.green = 0
		end
		
		img.each do |row|
		        row.each do |pixel|
	                	if tint_type == "r"
	                        	tint_red(pixel)
	                	elsif tint_type == "o"
					tint_orange(pixel)
				elsif tint_type == "y"
					tint_yellow(pixel)
				elsif tint_type == "b"
	                	        tint_blue(pixel)
	                	elsif tint_type == "g"
	                	        tint_green(pixel)
	                	elsif tint_type == "p"
					tint_purple(pixel)
				end
		        end
		end
#-----------------------------------------------------------------
	elsif effect == "h"
		puts "This reflects your image horizontally to create a mirror image."
		img.each do |row|
	        	new_row = []
	        	row.each do |pixel|
	        	        new_row.push({:red=>pixel.red,:green=>pixel.green,:blue=>pixel.blue})
	        	end
	        	row.each do |pixel|
	        	        new_pixel = new_row.pop
	        	        pixel.red = new_pixel[:red]
	        	        pixel.green = new_pixel[:green]
	        	        pixel.blue = new_pixel[:blue]
	        	end
		end
#----------------------------------------------------------------
	else
		puts "Not a valid effect!"
	end
	puts " "
	if effect == "b"
		name_effect = "bw"
	elsif effect == "n"
		name_effect = "photonegative"
	elsif effect == "h"
		name_effect = "reflected"
	end
	puts "Would you like to use another effect?"
	puts " This will apply your next effect to the image you just edited."
	effect = gets.chomp
	full_name_effect = "#{full_name_effect}_#{name_effect}"
end
new_img_name = full_name_effect + "_" + file_path
puts "The file #{new_img_name} has been created."
img.write("./#{new_img_name}")
