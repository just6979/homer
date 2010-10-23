#!/usr/bin/env python

"""uses rsync and ssh to send and receive selected dotfiles to and from others hosts

pretty simple, only works if you have the same username of both systems
and if they know each by each's own hostname.

in other words, it works inside my LAN, changes will be needed for anywhere else
"""

import os
import socket
import subprocess
import sys

if len(sys.argv) < 3:
	print "hey, you forgot something."
	sys.exit()
	
direction = sys.argv[1]
remotehost = sys.argv[2]

dotfiles = ".bashrc .gvimrc .hgrc .inputrc .profile .psqlrc .pythonrc .screenrc .vimrc .bash_logout .ipython .irssi .toprc .htoprc"

options="--perms --owner --group --times --sparse --partial --compress --human-readable --progress --itemize-changes --update --recursive"

user = os.environ["USER"]
home = os.environ["HOME"]

localhost = socket.getfqdn()

if direction == "push":
	print "Syncing selected dotfiles to %s" % (remotehost)

	args = ["rsync"]
	args.extend(options.split())
	args.extend(dotfiles.split())
	args.append("%s@%s:" % (user, remotehost))

elif direction == "pull":
	print "Syncing selected dotfiles from %s" % (remotehost)

	args = ["ssh", "%s@%s" % (user, remotehost), "rsync"]
	args.extend(options.split())
	args.extend(dotfiles.split())
	args.append("%s@%s:" % (user, localhost))
	
old_dir = os.getcwd()
os.chdir(home)

subprocess.call(args)

os.chdir(old_dir)

print "Done."

