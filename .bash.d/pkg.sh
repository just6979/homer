#!/usr/bin/env bash

#echo && echo -n 'Package system... '

if [[ -e /etc/debian_version ]]; then
	#echo 'found Debian base, using apt.'
#	alias pkg='apt-get'
	alias pkg='aptitude -V'
    alias spkg='sudo pkg'
	alias pkg2='apt-cache'
	alias pkginfo='pkg show'
	alias pkglist='pkg pkgnames'
	alias pkgsearch='pkg search'
    alias pkgpurge='spkg purge'
	alias pkgupdate='spkg update'
	alias pkgupgrade='spkg upgrade -V'
	alias pkgupgrade2='spkg dist-upgrade -V'
	alias pkgclean='spkg autoremove; spkg autoclean; spkg clean; spkg purge ~c'
	alias pkgsource='spkg source'
fi

if [[ -e /etc/fedora-release ]]; then
	#echo 'found Fedora base, using dnf.'
	alias pkg='dnf'
    alias spkg='sudo pkg'
    alias pkginfo='pkg info'
    alias pkglist='pkg list'
    alias pkgsearch='pkg search'
	alias pkgupdate='spkg makecache'
	alias pkgupgrade='spkg update'
	alias pkgupgrade2='spkg upgrade'
    alias pkgclean='spkg clean all'
    alias pkgsource='spkg source'
fi

alias pkginstall='spkg install'
alias pkgremove='spkg remove'
alias pkgcheck='pkgupdate && pkgupgrade'

function pkgsort {
    pkgsearch $1 | sort;
}
function pkgless {
    pkgsearch $1 | sort | less;
}
function pkgsearchall {
    pkgsearch all $1 | less;
}

# compat
alias pkgrm='pkgremove'
alias pkgadd='pkginstall'

