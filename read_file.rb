def read_file(path)
    begin 
        # read file from path (argumen from index) 
        file_data = File.readlines(path)
    rescue 
        puts "Invalid path"
        return "Invalid path"
    end 
end