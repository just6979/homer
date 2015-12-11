#!/usr/bin/env bash

#echo && echo -n 'Package system... '

if [[ -e /etc/debian_version ]]; then
	#echo 'found Debian base, using apt.'
	alias pkg='apt-get'
#	alias pkg='aptitude -V'
    alias spkg='sudo pkg'
	alias pkg2='apt-cache'
	alias pkginfo='pkg2 show'
	alias pkglist='pkg2 pkgnames'
	alias pkgsearch='pkg2 search'
    alias pkgpurge='spkg purge'
	alias pkgcheck='spkg update'
	alias pkgupgrade='spkg -uV upgrade'
	alias pkgupgrademore='spkg dist-upgrade -uV'
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
	alias pkgupgrademore='spkg upgrade'
    alias pkgclean='spkg clean all'
    alias pkgsource='spkg source'
fi

alias pkginstall='spkg install'
alias pkgremove='spkg remove'
alias pkgupdate='pkgcheck && pkgupgrade'

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

