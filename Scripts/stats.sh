#!/bin/sh

echo updating stats for www.justinfiniy.2y.net
/usr/local/bin/webalizer -Y -p -n justinfinity.2y.net -o /home/www/htdocs/stats /home/www/log/httpd-common.log

