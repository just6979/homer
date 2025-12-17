# Source - https://superuser.com/a/1846185
# Posted by glibg10b
# Retrieved 2025-12-15, License - CC BY-SA 4.0

#!/bin/bash

export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus

ibus-daemon -dr --panel=/usr/lib64/libexec/kimpanel-ibus-panel
