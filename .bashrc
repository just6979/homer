## .bashrc - bourne again shell startup file

#echo -n 'Setting up... '

#echo -n 'environment, '
umask 0002 # file perms: 644 -rw-rw-r-- (755 drwxrwxr-x for dirs)
export EMAIL='just6979@gmail.com'
export PATH=$PATH:$HOME/scripts:$HOME/Apps:$HOME/bin:$HOME/src/depot_tools:$HOME/Android/sdk/tools:$HOME/Android/sdk/platform-tools
export EDITOR='vim'
export PAGER='less'
export LESS='-FMRs~X -x4'
export PYTHONSTARTUP=$HOME/.pythonrc
export VIRTUALENV_USE_DISTRIBUTE=true
export PIP_RESPECT_VIRTUALENV=true

#echo -n 'bash, '
shopt -s cmdhist
shopt -s histappend
shopt -s no_empty_cmd_completion
shopt -s nullglob

#echo -n 'prompt, '
#'user@host:cwd[err]$ '
#export PS1='\u@\h:\w/[$?]\$ ';
export PS1='\[\e[0;34m\]\u@\h\[\e[m\]:\[\e[0;33m\]\w/\[\e[m\]\[\e[0;35m\][$?]\[\e[1;32m\]\$ \[\e[m\]\[\e[1;37m\]'
if [[ $TERM == 'xterm' ]]; then
	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[0;34m\]\u@\h\[\e[m\]:\[\e[0;33m\]\w/\[\e[m\]\[\e[0;35m\]($?)\[\e[1;32m\]\$ \[\e[m\]\[\e[0;37m\]'
fi
if [[ $TERM == 'screen' ]]; then
	export PS1='\[\033]0;\u@\h:\w/[$?]\$\007\]\[\e[0;34m\]\u@\h\[\e[m\]:\[\e[0;33m\]\w/\[\e[m\]\[\e[0;35m\][$?]\[\e[1;32m\]\$ \[\e[m\]\[\e[0;37m\]'
	export PROMPT_COMMAND='echo -ne "\033k\033\\"'
fi

#echo -n 'shortcuts, '
alias rsync_backup='rsync -r -t -p -o -g -v --progress --delete -u -l -H -i -s -F /home/justin/'
alias rsync_personal='rsync -r -t -p -o -g -v --progress --delete -u -l -H -i -s --filter="dir-merge .rsync-prsnl-filter" /home/justin/'
alias jsh='bash -l'
alias ssh_jj='ssh justin@jester'
alias ssh_h.jw.net='ssh justin@home.justinwhite.net'
function awsset {
    export AWS=$1;
}
function awsgo {
    ssh -X -i ~/.ssh/junglekeys.pem ec2-user@$AWS;
}
function awsrun {
    awsset $1;
    awsgo;
}
#be paranoid and prompt, unless forced with -f
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'
# helpers
alias t='tail -n$LINES -f'
alias cdc='cd && clear'
alias rebash='source ~/.bashrc'
alias psfind='ps aux | grep -i'
alias jtop='htop -u justin'
# quick sudos
alias svim='sudo vim'
alias sgvim='sudo gvim'
# screen shortcuts
alias s='screen -AU'
alias sS='s -S'
alias sls='s -ls'
alias sr='s -r'
alias srd='s -rd'
alias sx='s -x'
# make ls show colors and filetype symbols
export LSCOLORS='Exfxcxdxbxegedabagacad'
if uname -a | egrep "Linux" &> /dev/null; then
    alias ls='ls -Fh --color=auto';
fi
if uname -a | egrep "BSD" &> /dev/null; then
    alias ls='ls -Fh -G';
fi
if uname -a | egrep "armv7" &> /dev/null; then
    alias ls='busybox ls -Fh --color=auto';
fi
alias lsa='ls -a'
alias ll='ls -l'
alias lla='ll -a'
alias lld='ll -d'

#echo && echo -n 'Package system... '
if [[ -e /etc/debian_version ]]; then
	#echo 'found Debian base, using apt.'
	alias service='sudo service'
	alias pkg='sudo aptitude'
    alias pkginfo='pkg show'
    alias pkglist='pkg list'
    alias pkgsearch='pkg search'
	alias pkgrefresh='pkg update'
	alias pkgupdate='pkg safe-upgrade -V'
	alias pkgupgrade='pkg full-upgrade -V'
    alias pkgclean='pkg clean'
    alias pkgsource='pkg source'
fi
if [[ -e /etc/fedora-release ]]; then
	#echo 'found Fedora base, using yum.'
	alias service='sudo service'
	alias pkg='sudo yum'
    alias pkginfo='pkg info'
    alias pkglist='pkg list'
    alias pkgsearch='pkg search'
	alias pkgrefresh='pkg clean && pkg makecache'
	alias pkgupdate='pkg update'
	alias pkgupgrade='pkg upgrade'
    alias pkgclean='pkg clean'
    alias pkgsource='pkg source'
fi
function pkgsearchless {
    pkgsearch $1 | less;
}
function pkgsearchsort {
    pkgsearch $1 | sort | less;
}
function pkgsearchall {
    pkgsearch all $1 | less;
}
alias pkgadd='pkg install'
alias pkgrm='pkg remove'
alias pkgcheck='pkgrefresh && pkgupdate'

## CM setup & build shortcuts
export CM9_ROOT='/home/justin/Android/CM9'
alias cm_find='if [ `pwd` != "$CM9_ROOT" ]; then echo "Changing to $CM9_ROOT"; cd $CM9_ROOT; fi'
alias cm_sync='cm_find; echo "Running \"repo sync\"."; repo sync'
alias cm_envsetup='cm_find; echo "Running envsetup."; source build/envsetup.sh'
alias cm_set_experimental='cm_find; echo "Setting up for "Crispy" experimental build."; export CM_EXTRAVERSION="Crispy"; export CM_EXPERIMENTAL'
alias cm_set_unofficial='cm_find; echo "Setting up for UNOFFICIAL build."; unset CM_EXTRAVERSION; unset CM_EXPERIMENTAL; export CM_UNOFFICIAL=1'
alias cm_clean='cm_find; echo "Cleaning build output."; make clobber'
alias cm_clear_build_prop='cm_find; echo "Clearing build.prop."; rm -f otp-crespo4g/system/build.prop'
alias cm_experimental='cm_find; cm_envsetup; cm_set_experimental; echo "Building CM9-EXPERIMENTAL-Crispy for crespo4g."; time brunch crespo4g'
alias cm_unofficial='cm_find; cm_envsetup; cm_set_unofficial; echo "Building CM9-UNOFFICIAL for crespo4g."; time brunch crespo4g'
alias cm_rebuild='cm_unofficial'
alias cm_build='cm_clear_build_prop; cm_unofficial'
alias cm_extra_env='export TARGET_BOOTANIMATION_PRELOAD=true; export TARGET_BOOTANIMATION_TEXTURE_CACHE=true;'

# CM fresh build shortcut
function fresh_bacon {
    OWD=`pwd`;
    cm_find;
    cm_sync;
    cm_unofficial;
    echo "Fresh bacon here!: $CM9_ROOT/otp-crespo4g/"
    cd $OWD;
}

# ARM cross compiling toolchain setups
function cross-aosp-arm-linux-androideabi {
    export ARCH=arm
    export CROSS_COMPILE=arm-linux-androideabi-
    export PATH=$PATH:~/Android/AOSP/prebuilt/linux-x86/toolchain/arm-linux-androideabi-4.4.x/bin/
}

function cross-cm9-arm-eabi {
    export ARCH=arm
    export CROSS_COMPILE=arm-eabi-
    export PATH=$PATH:~/Android/CM9/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin
}

function cross-x-cm9-arm-linux-androideabi {
    export ARCH=arm
    export CROSS_COMPILE=arm-eabi-
    export PATH=$PATH:~/Android/CM9/prebuilt/linux-x86/toolchain/arm-linux-androideabi-4.4.x/bin
}

function cross-sourcery-arm-none-eabi {
    export ARCH=arm
    export CROSS_COMPILE=arm-none-eabi-
    export PATH=$PATH:~/Apps/sourcery-2011.09/bin/
}

function cross-x-sourcery-arm-none-linux-gnueabi {
    export ARCH=arm
    export CROSS_COMPILE=arm-none-linux-gnueabi-
    export PATH=$PATH:~/Apps/sourcery-2011.09/bin/
}

function fill-skeleton {
    ROOT='/home/justin/Android/kernels'
    KERNEL=$1
    SKELETON=$2
    K=$ROOT/$KERNEL
    S=$ROOT/$SKELETON
    cp -i $K/arch/arm/boot/zImage $S/kernel
    cp -i $K/drivers/net/wireless/bcm4329/bcm4329.ko $S/system/lib/modules
    cp -i $K/drivers/scsi/scsi_wait_scan.ko $S/system/lib/modules
}

alias agent_start='eval `ssh-agent`'
alias agent_kill='eval `ssh-agent -k`'
alias agent_load_dvcs='ssh-add ~/.ssh/dvcs-id_rsa'

export USE_CCACHE=1
export CCACHE_DIR='/home/justin/tmp/ccache/'

