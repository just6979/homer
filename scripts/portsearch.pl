#!/usr/bin/perl
#-
# Copyright (c) 2000 Mark Ovens
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer
#    in this position and unchanged.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#      $Id$
#


# Each port record in INDEX contains 10 fields, delimited by ``|'', some
# of which may be empty. The fields are:
#
# distribution-name|port-path|installation-prefix|comment| \
# description-file|maintainer|categories|build deps|run deps|www site  


use strict;
use Getopt::Std;
use vars qw/ $key @list %fields %list %opts /;

#
# Global variables
#

my $VERSION = "1.0";
my $file  = "/usr/ports/INDEX";
my $match  = 1;
my $count = 0;

# We only need 7 of the 10 fields in a record; define which ones in a
# hash slice to ignore the un-needed ones. This also makes it easy to
# add or remove fields in the future.

@fields{qw(n p i m x b r)} = (0, 1, 3, 5, 6, 7, 8);

#
# Print a basic help message
#

sub usage() {
    print(STDERR "
Usage: portsearch [-h] [-n name] [-p path] [-i info] [-m maint] [-x index]
		[-b b_deps] [-r r_deps] [-d deps] [-f file]

");
} # usage()

#
# Print a more verbose help message
#

sub help() {
    print(STDERR "portsearch $VERSION - A utility for searching the ports tree.

Options:

  -n name	Search for \"name\" in name of ports
  -p path	Search for \"path\" in location of ports
  -i info	Search for \"info\" in ports COMMENT
  -m maint	Search for \"maint\" in ports Maintainer
  -x index	Search for \"index\" in ports categories
  -b b_deps	Search for \"b_deps\" in build depends of ports
  -r r_deps	Search for \"r_deps\" in run depends of ports
  -d deps	Search for \"deps\" in both build & run depends of ports
  -f file	Use \"file\" instead of /usr/ports/INDEX
  -h		Print this message and exit

Report bugs to <marko\@freebsd.org>.

");
} # help()

#
# The program proper
#

MAIN: {
				# No command-line args
    if ($#ARGV == -1) {
	usage();
	exit(1);
    }

    getopt('fnpimxbrd', \%opts);
				# Command-line args, but without options
    if (keys(%opts) == 0 ) {
	usage();
	exit(1);
    }
				# If ``-h'', ignore any other options
    if (defined($opts{"h"})) {
	help();
	exit(1);
    }
				# A different INDEX file
    if (defined($opts{"f"})) {
	$file = $opts{"f"};
    }
				# If ``-d'' used we don't want ``-b'' & ``-r''
    if (defined($opts{"d"})) {
	delete $opts{"b"};
	delete $opts{"r"};
    }
				# Finished with it now so remove it from hash
    delete $opts{"f"};
	
    open(INDEX, "$file") || die "Unable to open $file";

    while (<INDEX>) {
	chomp;
	@list = split(/\|/);

        $match = 1;
				# All searches are case-insensitive! 
				# For ``-d'' search both build & run depends.
				# Only fail to match if not found in either.
	foreach $key (keys (%opts)) {
	    if ($key eq "d") {
		if ($list[$fields{"b"}] !~ m#$opts{$key}#i &&
				  $list[$fields{"r"}] !~ m#$opts{$key}#i) {
		    $match = 0;
		    last;
		    }
	    } else {
		if ($list[$fields{$key}] !~ m#$opts{$key}#i) {
		    $match = 0;
		    last;
		}
	    }
	} # foreach

	if ($match == 1) {
	    $count++;
	    write;
	}

    } # while

    close(INDEX);

    print ("Number of matching ports = $count\n\n");

} # MAIN


format STDOUT =

Port:	@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$list[0]
Path:	@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$list[1]
Info:	^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$list[3]
~~      ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$list[3]
Maint:	@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$list[5]
Index:	@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$list[6]
B-deps:	^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$list[7]
~~      ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$list[7]
R-deps:	^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$list[8]
~~      ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$list[8]

.
