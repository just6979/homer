#!/usr/bin/env bash

#echo && echo -n 'Package system... '
if [[ -e /etc/debian_version ]]; then
	#echo 'found Debian base, using apt.'
	alias service='sudo service'
	alias pkg='sudo apt-get -V'
	alias pkg2='aptitude -V'
	alias pkg3='apt-cache'
	alias pkginfo='pkg2 show'
    alias pkgrm='pkg purge'
	alias pkglist='pkg3 pkgnames'
	alias pkgsearch='pkg2 search'
	alias pkgrefresh='pkg update'
	alias pkgupdate='pkg upgrade -V'
	alias pkgupgrade='pkg dist-upgrade -V'
	alias pkgclean='pkg autoremove; pkg autoclean; pkg clean; sudo pkg2 purge ~c'
	alias pkgsource='pkg source'
fi
if [[ -e /etc/fedora-release ]]; then
	#echo 'found Fedora base, using yum.'
	alias service='sudo service'
	alias pkg='sudo yum'
    alias pkginfo='pkg info'
    alias pkgrm='pkg remove'
    alias pkglist='pkg list'
    alias pkgsearch='pkg search'
	alias pkgrefresh='pkg clean && pkg makecache'
	alias pkgupdate='pkg update'
	alias pkgupgrade='pkg upgrade'
    alias pkgclean='pkg clean'
    alias pkgsource='pkg source'
fi
function pkgsort {
    pkgsearch $1 | sort;
}
function pkgless {
    pkgsearch $1 | sort | less;
}
function pkgsearchall {
    pkgsearch all $1 | less;
}
alias pkgadd='pkg install'
alias pkgcheck='pkgrefresh && pkgupdate'
