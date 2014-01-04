#!/usr/bin/env ruby -w

out = []
tmpfile = "tmpfile"
found = false

ARGV.each do |arg|
	print arg + "\tparsing..."
	File.open arg do |file|
		file.each do |line|
			line.chomp!
			next if line.empty?
			next if line =~ /Last updated:/
			if line =~ /<!--time-->/
				found = true
				out << line
				out << "<em>Last updated: " + File.stat(arg).mtime.strftime("%a %Y-%m-%d %H%M.%S %Z") + "</em>\n"
			else
				out << line
			end
		end
	end
	if found
		print " updating..."
		File.open(tmpfile, File::CREAT|File::TRUNC|File::RDWR, 0664) do |file|
			out.each do |line|
				file.puts line
			end
		end
		File.rename(tmpfile, arg)
	end
	print "\tdone.\n"
end
