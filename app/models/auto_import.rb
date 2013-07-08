class AutoImport

	attr_accessor :folders, :path, :size, :time, :success, :error


	def initialize(path , size , time ) 
		@success = 0
		@error = 0
		@path = path
		@size = size
		@time = time

		@folders = Dir[File.join(path, '*')]
	end


	def print_config
		puts "*************Executing AutoImport***************".red
		puts "Problems PATH #{@path}".blue
		puts "Size file #{@size}".blue
		puts "Time Limit #{@time}".blue
		
	end
	def import
		print_config
		@folders.each do |folder|

			title = folder.match('[^\/]+$').to_s
			java = get_file(folder, 'java')

			cpp = get_file(folder, 'cpp') unless java

			judgeSolution = java ? java : cpp
				
			
			body = get_file(folder, 'pdf')
			input = get_file(folder, 'in')
			output = get_file(folder, 'out')


			hash ={title: title,
						 active: true,
						 body: body,
						 input: input,
						 output: output,
						 judgeSolution: judgeSolution,
						 size: size,
						 time:   time
						}
			create_problem (hash)
		end
		{success: @success, error: @error}
	end

	def get_file (path, ext)
		begin
			File.open(Dir[File.join(path, "*.#{ext}")].first)	
		rescue Exception => e
			 puts ":( File .#{ext} in #{path} NOT FOUND".red
		end
		
	end

	def create_problem (hash)
		begin
			Problem.create!(hash)
			@success += 1			
		rescue Exception => e
			puts ":( ERROR: #{e.message}".red
			@error += 1	
		end
		
	end


end