#!/usr/bin/perl

use strict;

my $session = "irc";
my $client = "irssi";

# find sessions
my $existing = `screen -ls | grep $session`;

# no session running, start one up
unless ($existing) {
	print "no existing $session sessions, starting new...\n";
	exec "screen -mS $session $client" or die "can't run screen to create new session";
}

# session found
print "found existing $session session, reconnecting now...\n";
exec "screen -x $session" or die "can't run screen to reconnect";


__END__
