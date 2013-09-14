#!/bin/sh

title='qfusion'
title_url='https://github.com/viciious/qfusion'
git_url='git://github.com/viciious/qfusion.git'

hostname=$(hostname)
unix_name='buildbot'

admin='Admin'
admin_email="admin@$hostname"

# Project title
echo "Project title: [$title]"
read user_title
[ ! -z "$user_title" ] && title="$user_title"

# Project URL
echo "Project URL: [$title_url]"
read user_title_url
[ ! -z "$user_title_url" ] && title_url="$user_title_url"

# Project GIT URL
echo "Project GIT: [$git_url]"
read user_git_url
[ ! -z "$user_git_url" ] && git_url="$user_git_url"

# Project admin
echo "Project admin: [$admin]"
read user_admin
[ ! -z "$user_admin" ] && admin="$user_admin"

# Project admin email
echo "Project admin: [$admin_email]"
read user_admin_email
[ ! -z "$user_admin_email" ] && admin_email="$user_admin_email"

# Buildbot hostname
echo "Hostname: [$hostname]"
read user_hostname
[ ! -z "$user_hostname" ] && hostname="$user_hostname"

# Buildbot unix username
echo "Buildbot unix username: [$unix_name]"
read user_unix_name
[ ! -z "$user_unix_name" ] && unix_name="$user_unix_name"

cd inc

./buildbot-setup.sh "$PWD/buildbot-master.cfg.tpl" "$title" "$title_url" "$git_url" "$hostname" "$unix_name" "$admin" "$admin_email"

./gcc-setup.sh

./mingw-setup.sh
