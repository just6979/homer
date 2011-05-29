#!/usr/bin/perl

# time2size.pl
# Justin White
# (C) 2001

# put in the wild world under the MIT software license
# see: http://www.opensource.org/licenses/mit-license.html
# this means you can do whatever you want with it
# as long as you attribute this little chunk of code to me

# usage: time2size.pl <mm:ss>

# takes one argument, time in the format mm:ss
# prints the time in mm:ss format, and in seconds
# then prints the resulting file size in bits, bytes, kilobytes, and megabytes

@time = split(/:/, $ARGV[0]) ;
$min = $time[0] ;
$sec = $time[1] ;

$sec += $min * 60 ;
print "Playing Time is:\n\t", $time[0], ":", $time[1] ;
print "\n\t", $sec, " seconds\n" ;

print "File size is:\n" ;

# size in bits is seconds * 44100 samples at 16 bits each for 2 channels
$size = $sec * 44100 * 16 * 2;
print "\t", $size, " bits\n" ;

$size /= 8 ; # divide by 8 to get bytes ;
print "\t", $size, " bytes\n" ; 

$size /= 1024 ; # kilobytes ;
print "\t", $size, " kilobytes\n" ; 

$size /= 1024 ; # megabytes ;
print "\t", $size, " megabytes\n" ; 
