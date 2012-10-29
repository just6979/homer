#!/usr/bin/env perl -w

# usage: renamer.pl [-r] "orig_text" "replace_text"
# in the directory you want to change, use -r for recursion

#check parameters
parse_args() ;
$recurse = 1;
#confirm correct parameters 
confirm() ;
#do it
go_dir(`pwd`) ;

# display help type stuff
sub show_help {
	show_ver() ;
	print "usage:\n" ;
	print "  renamer.pl [-r] -o[orig] -n[new]\n\n" ;
	print "switches:\n" ;
	print "  -h, --help\tdisplays this screen (duh!).\n" ;
	print "  -v\t\tdisplays the version info seen at the top of this.\n" ;
	print "  -r\t\tenable recursion through subdirs, ad infinitum\n" ;
	print "  -o[orig]\tspecifies the token to be replaced.\n" ;
	print "\t\t[orig] must be at least one character\n" ;
	# this is because i didn't spend the time to make a full
	# argument parsing fucntion in this little script :-P
	print "\t\tand the -o switch MUST come before the -n switch.\n" ;
	print "  -n[new]\tspecifies token to replase [orig] with.\n" ;
	print "\t\tif [new] is empty. [orig] will be removed,\n" ;
	print "\t\tie: [orig] is replaced with nothing.\n\n" ;
}

# display version info 
sub show_ver {
	print "\nrenamer.pl, by Justin White (C) 2001\n" ;
	print "  This software is released under the BSD license.\n" ;
	print "  You can find more about this at\n" ;
	print "  http://www.opensource.org/licenses/bsd-license.html\n\n" ;
}

# read the command line arguments and decide what to do with them
sub parse_args {
	my $index = 0, $good_args = 0 ;
	# -v means show the version info
	if ($ARGV[0] eq "-v") {
		$good_args = 1 ;
		show_ver() ;
		exit ;
	# if either of the normal help args are passed, show the help stuff
	} elsif ($ARGV[0] eq "-h" || $ARGV[0] eq "--help") {
		$good_args = 1 ;
		show_help() ;
		exit ;
	# check if the user wants recursion
	} elsif ($ARGV[0] eq "-r") {
		$good_args = 1 ;
		$recurse = 1 ;
		$index = 1 ;
	}

	# ensure the args telling what to replace with what are formed ok
	if ($ARGV[$index] =~ /^-o/) {
		$good_args = 1 ;
		$orig = $ARGV[$index] ;
		$orig =~ s/^-o// ;
		$index++ ;
	} else {
		$good_args = 0 ;
	}

	if ($ARGV[$index] =~ /^-n/) {
		$good_args = 1 ;
		$new = $ARGV[$index] ;
		$new =~ s/^-n// ;
	} else {
		$good_args = 0 ;
	}

	if (!$good_args) {
		print "  I don't understand what you want to do.\n" ;
		print "  Use the -h switch for options and syntax.\n" ;
		exit ;
	}
}

# confirm operations to [hopefully] prevent typos from making bad things happen
sub confirm {
	my $input ;
	print "  I am about to change all '$orig' to '$new'" ;
	if ($recurse) {
		print ", recursively" ;
	}
	print ".\n" ;
	print "  Are you sure I should proceed? [y,n]" ;
	#wait for a good answer
	while (defined($input = <STDIN>)) {
		chomp $input ;
		#user gave a good answer, break out of loop
		if ($input =~ /[Yy]/) {
			last ;
		#user didn't give a good answer, see ya later
		} else {
			die "  I will not proceed. Bye.\n" ;
		}
	}
}

# go into passed dir and perfrom the operation on each file and then each dir,
# recursing into each dir if -r was specified
sub go_dir {
	#must keep these local, otherwise recursion won't work :-P
	my ($curdir, @dirs, @files, $newname) ;
	$curdir = $_[0] ;
	chomp $curdir ;
	# go through curdir
	foreach (<$curdir/*>) {
		#put abolute dir names in @dirs
		if (-d && $_ ne ".." && $_ ne ".") {
			chomp $_ ;
			$dirs[$#dirs+1] = $_ ;
		#put absolute file names in @files
		} elsif (-f) {
			chomp $_ ;
			$files[$#files+1] = $_ ;
		}
	}
	# do it on the files
	print "files in $curdir\n" ;
	foreach (@files) {
		print "\toriginal name: $_\n" ;
		$newname = $_ ;
		$newname =~ s/$orig/$new/g ;
		$newname =~ s/_-_/-/g;
		rename ($_, $newname) ;
		print "\tupdated name: $newname\n" ;
	}
	#do it on the dirs, and branch into them if recursion was requested
	print "directories in $curdir\n" ;
	foreach (@dirs) {
		print "\toriginal name: $_\n" ;
		$newname = $_ ;
		$newname =~ s/$orig/$new/g ;
		rename ($_, $newname) ;
		print "\tupdated name: $newname\n" ;
		if ($recurse) {
			go_dir($_) ;
		}
	}
}
