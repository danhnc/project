#!/usr/bin/ruby

require 'pg'

# if ARGV.length != 1 then
#     puts "Usage: prepared_statement.rb rowId"
#     exit
# end

# rowId = ARGV[0]

begin
	path = "/home/local/ELARION/danhnc/training/ruby/sample.csv"
	con = PG.connect :dbname => 'danhnc', :user => 'danhnc'

	# con.prepare 'stm1', "SELECT * FROM Cars WHERE name=$1"
 #    rs = con.exec_prepared 'stm1', [rowId]

 #    puts rs.values
    filename = File.basename(path, ".*")
	# puts filename
	row = File.readlines(path)
	row.each do |e|
		puts e
	# 	col = row.split(',')
	# 	puts col[0]
	end
    con.exec "DROP TABLE IF EXISTS #{filename}"
    att_name = row[0].split(',')
    con.exec "CREATE TABLE #{filename} (#{att_name[0]}  INTEGER PRIMARY KEY)"
    att_index = 1
    while att_index < att_name.size do
    	con.exec "ALTER TABLE #{filename} ADD #{att_name[att_index]} VARCHAR(20)"
    	att_index += 1
    end
    row_index = 1
    while row_index < row.size do
    	col = row[row_index].split(',')
    	con.exec "INSERT INTO #{filename} VALUES(#{col[0]})"
    	# break
    	col_index = 1
    	while col_index < col.size do
    		# break
    		# puts col[col_index]
    		con.exec "UPDATE #{filename} SET #{att_name[col_index]}='#{col[col_index]}' WHERE #{att_name[0]}=#{row_index}"
    		# con.exec "UPDATE #{filename} SET #{att_name[col_index]}='A' WHERE #{att_name[0]}=#{row_index}"

    		# break
    		col_index += 1
    		# break;
    	end
    	# break	
    	row_index += 1
    end

    # con.exec "CREATE TABLE #{filename}(Id INTEGER PRIMARY KEY, 
    #     #{att_name[1]} VARCHAR(20), #{att_name[2]} VARCHAR(20))"
    # con.exec "CREATE TABLE #{filename}(Id INTEGER PRIMARY KEY) 
    # i = 1;
    # puts arr.size
    # while i < arr.size do
    # 	col = arr[i].split(',')
    # 	con.exec "INSERT INTO #{filename} VALUES(#{i},#{col[1]},#{col[2]})"
    # 	i += 1
    
    # end
    # col = arr[1].split (',')
    # i = 'ab'
    # # puts '1'.instance_of? String
    # # con.exec "UPDATE #{filename} SET name='abc' WHERE id=4" 
    # con.exec "INSERT INTO #{filename} VALUES(5,'#{i}',#{col[2]})"
 #    con.exec "INSERT INTO Cars VALUES(1,'Audi',52642)"
 #    con.exec "INSERT INTO Cars VALUES(2,'Mercedes',57127)"
 #    con.exec "INSERT INTO Cars VALUES(3,'Skoda',9000)"
 #    con.exec "INSERT INTO Cars VALUES(4,'Volvo',29000)"
 #    con.exec "INSERT INTO Cars VALUES(5,'Bentley',350000)"
 #    con.exec "INSERT INTO Cars VALUES(6,'Citroen',21000)"
 #    con.exec "INSERT INTO Cars VALUES(7,'Hummer',41400)"
 #    con.exec "INSERT INTO Cars VALUES(8,'Volkswagen',21600)"
    
rescue PG::Error => e
	puts e.message
ensure

	# rs.clear if rs
	con.close if con
end