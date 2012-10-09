#!/bin/bash

#echo -n 'shortcuts, '
alias setup


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
