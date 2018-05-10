# text = File.basename("~/training/ruby/sample2.csv")
# puts text
# arr_of_arrs = CSV.read("~/traning/ruby/sample2.csv")
# puts arr_of_arrs
# aFile = File.new("/home/local/ELARION/danhnc/training/ruby/sample2.csv", "r")
# if aFile
# 	content = aFile.sysread(100)
# 	puts content
# else
# 	puts "Error"
# end
filename = File.basename("/home/local/ELARION/danhnc/training/ruby/sample2.csv", ".*")
puts filename
arr = File.readlines("/home/local/ELARION/danhnc/training/ruby/sample2.csv")
arr.each do |row|
	# puts row.split(',')
	col = row.split(',')
	puts col[0]
end