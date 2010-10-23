#!/usr/bin/env python

"""uses tar and ssh to copy chosen dotfiles to other machines
"""

import os
import socket
import subprocess
import sys

dot_files = '.bashrc .gvimrc .hgrc .inputrc .profile .psqlrc .pythonrc .screenrc .vimrc .bash_logout .toprc .htoprc'
tar_file = 'dots.tar'

old_dir = os.getcwd()
home = os.environ["HOME"]
os.chdir(home)

if len(sys.argv) < 2:
    print 'Packing only.'
    remote_path = None
if len(sys.argv) == 2:
    remote_host = sys.argv[1]
    remote_path = '%s:~/' % (remote_host)
    print 'Packing and sending to %s.' % remote_path
    sys.exit()

print 'Collecting files...'
args = ['tar', '-cvf', tar_file]
args.extend(dot_files.split())
subprocess.call(args)

if remote_path:
    print 'Sending collection to %s...' % (remote_path)
    args = ['scp', tar_file, remote_path]
    subprocess.call(args)

    print 'Cleaning up...'
    os.remove(tar_file)

os.chdir(old_dir)

print 'Done.'
