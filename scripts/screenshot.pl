#!/usr/bin/perl -w

use POSIX;

if (!defined($snapdir = $ARGV[0])) {
	print "usage: $0 <dir for snaps to go>\n";
}

unless ($snapdir =~ /\/$/) {
	$snapdir .= "/";
}

$date = POSIX::strftime("%Y%m%d-%H%M%S",localtime(time));

$filename = $snapdir . "screen_" . $date . ".png";

`import -window root $filename`;

