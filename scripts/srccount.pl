#!/usr/bin/env perl -w

=copyright
srccount.pl
Justin White
(C) 2001

put in the wild world under the MIT software license
see: http://www.opensource.org/licenses/mit-license.html 
this means you can do whatever you want with it
as long as you attribute this little chunk of code to me

=usage
usage: srccount.pl [-r] (file|directory)...
	counts # of lines of code and comments
	use -r flag to recurse through directories

=changelog

(KS) 2001/07/25: POD support added
(JW) 2001/07/26: then modified a bit more by me :-)
(JO) 2001/12/06: Directory Recursion and formats added
(KS) 2001/12/10: "Inline" comment counting added; some general cleanup


People:
	JW: Justin White <just6979@yahoo.com>
	KS: Keith Smiley <panner@qx.net>
	JO: Jarrod Overson <jarrod@dumbfounded.org>

=cut

# play nice
use strict;

use Cwd;

# what file are we looking at?
my @files;
# count unreadable or non-files
my $bad_files = 0;
# initialize some total values
my %total = (
	code	        => 0,
	comments        => 0,
	comments_inline => 0,
	lines	        => 0,
	pod	            => 0
);
# directory recursion flag
my $dir_recurse = 0;
# array full o' file extensions, defaulted for perl
my @file_exts = ('pm','pl');
# know what to prepend to filenames for relative dir's.
my $pwd = cwd;

#chop $pwd;	#get rid of trailing newline

# did they pass us a filename?
if (@ARGV) {
	# yes, are any of them valid filenames?
	foreach (@ARGV) {
		if (-f && -r) {		  # a text file and a readable file?
			# yes, save it
			push @files, $_;
		} elsif ($_ eq '-r') {    # recursion flag set?
			$dir_recurse = 1;
		} elsif (-d) {		  # a directory?
			$_=$pwd.'/'.$_ if(m/^[^\\\/]/);
			directory_recurse($_,\@files,$dir_recurse);
		} else {
			# nope, count it
			$bad_files++;
		}
	}
}

# find any unreadables?
if ($bad_files) {
	# tell the user
	print "$bad_files file", ($bad_files == 1) ? '' : 's', " were unreadable...\n";
}

# no readable files given
if (!@files) {
	# tell the user how to work me
	print "usage: srccount.pl [-r] (file|directory)\n";
	print "\t counts # of lines of code and comments\n";
	print "\t use -r flag to recurse through directories\n\n";
	# even give them an example
	print "example:\n";
	print "\$ srccount.pl $0\n";
	# push my own filename onto the list to count
	push @files, $0;
}

# march down the list of files pulled from the parameters
foreach my $file (@files) {
	# "Hold the line! Hold the line!" -Maximus 
	my $total       = 0;
	my $code        = 0;
	my $comm        = 0;
	my $comm_inline = 0;
	my $pod         = 0;
	# are we counting pod or not?
	my $countpod    = 0;
	
	# open that pretty little file
	open SRC, $file or die "$file: $!";

	# scan through said file
	while (<SRC>) {
		# count 'em all!
		$total++;

		## pod support
		# if it starts with "=cut"
		if (/^=cut/) {
			# done counting pod
			$countpod = 0;
			# but count the "=cut" line as pod too
			$pod++;
		# if it starts with "="
		} elsif (/^=/) {
			# start counting pod
			$countpod = 1;
			# count "=whatever" line as part of the pod
			$pod++;
		# if we'd found a pod start point
		} elsif ($countpod and !/^\s*$/) {
			# count 'em up
			$pod++;
		## end pod support
		# if it doesn't start with # and isnt blank
		} elsif (!/^\s*\#/ && !/^\s*$/) {
			# it's code!
			$code++;
			# check for an inline comment (very rough guess)
			$comm_inline++ if /#/;
		# else if it's not blank and it's not a hashbang
		} elsif (!/^\s*$/ && !/^\s*\#!/) {
			# it's a comment!
			$comm++;
		}
	}

	# close that innocent file and be nice
	close SRC;

	
	if(length($file)>40) {			# if we have a long file name
		$file=~s/(.{6}).*(.{25})/$1...$2/; # trim out the middle
	}					# so we remain nicely formatted

	# for the formatting below :)
	my $comm_idisp = "($comm_inline)";

	#set up some formats so that the output looks all pretty
	format STDOUT_TOP =

             File Name                   Code     Comments     POD    Lines
-------------------------------------------------------------------------------
.
	format STDOUT =
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<@>>>>>>>   @>>>> @<<<<  @>>>>>  @>>>>>>
$file,                            $code,   $comm, $comm_idisp,  $pod,   $total
.

	# give up the data and no one gets hurt
	write;

	$total{code}            += $code;     #update the totals
	$total{comments}        += $comm;
	$total{comments_inline} += $comm_inline;
	$total{pod}             +=$pod;
	$total{lines}           +=$total;

	#print "$file: $total lines total, $code of code, $comm of comments, $pod of POD\n";
	# print "oh, and " . int($total-($code+$comm+$pod)) . " blank lines\n";
}


# only display totals footer if we had more than one file
if (@files > 1) {
	my $comm_total = "($total{comments_inline})";

	# Hack in a formatted footer with totals.
	$^A = "";
	formline(qq|
-------------------------------------------------------------------------------
                Totals               @>>>>>>>   @>>>> @<<<<  @>>>>>  @>>>>>>\n|,
          $total{code},$total{comments},$comm_total,$total{pod},$total{lines});
	print $^A;
} else {
	print "\n";   # well, a little extra formatting :)
}

# all done!

# some subs for directory recursion.

sub directory_recurse {
	my $directory = shift;		# directory to slurp
	my $files = shift;		# arrayref
	my $recurse = shift;		# stick to this level or no?
	
	chdir $directory;		# change to dir $directory
	
	$directory.='/' if $directory =~ m/[^\\\/]$/;
	
	foreach(@file_exts) {		# add all the right files to the array
		foreach(<*.$_>) {	# by globbing for the file extensions
			push @{$files},$directory.$_;
		}
	}
	if($recurse) {			# if we want to recurse through each dir
		foreach(dirs_in_dir($directory)) {#find out which dirs are there
			$_=$directory.$_;
			directory_recurse($_,$files,$recurse);	# and do 'em up
		}
	}

	return 1;
}
sub dirs_in_dir {	# i know my naming system is amazing, you don't have
	my $directory = shift;					#to tell me.
	my @dirs;
	
	chdir $directory;
	
	my @all_files = glob('*');
	foreach(@all_files) {
		push @dirs,$_ if(-d);	# just report back which files
	}				# happen to be directories
	return @dirs;			# tada!
}
