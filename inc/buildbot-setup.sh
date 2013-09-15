#!/bin/sh

cfg_template="$1"

title="$2"
title_url="$3"
git_url="$4"

hostname="$5"
unix_name="$6"

admin="$7"
admin_email="$8"

crosscompile_dir='tools/cross_compile/'
source_dir='source/'
www_dir='public_html/bin/'

slave_name='buildbot'
slave_pass='buildbot'
slave_port='9989'

buildbot_http_port='8010'

irc_server='irc.quakenet.org'
irc_nickname='gitpork'
irc_channels=''

# Cross compilation tooldir
echo "Cross compilation toolset directory: [$crosscompile_dir]"
read user_crosscompile_dir
[ ! -z "$user_crosscompile_dir" ] && crosscompile_dir="$user_crosscompile_dir"

# Source code dir
echo "Source code directory: [$source_dir]"
read user_source_dir
[ ! -z "$user_source_dir" ] && source_dir="$user_source_dir"

# WWW directory
echo "Web destination directory: [$www_dir]"
read user_www_dir
[ ! -z "$user_www_dir" ] && www_dir="$user_www_dir"

# Buildbot slave login name
echo "Buildbot slave login: [$slave_name]"
read user_slave_name
[ ! -z "$user_slave_name" ] && slave_name="$user_slave_name"

# Buildbot slave password
echo "Buildbot slave password: [$slave_pass]"
read user_slave_pass
[ ! -z "$user_slave_pass" ] && slave_pass="$user_slave_pass"

# Buildbot slave port
echo "Buildbot slave port: [$slave_port]"
read user_slave_port
[ ! -z "$user_slave_port" ] && slave_port="$user_slave_port"

# Buildbot irc server
echo "Buildbot IRC server: [$irc_server]"
read user_irc_server
[ ! -z "$user_irc_server" ] && irc_server="$user_irc_server"

# Buildbot irc nickname
echo "Buildbot IRC nickname: [$irc_nickname]"
read user_irc_nickname
[ ! -z "$user_irc_nickname" ] && irc_nickname="$user_irc_nickname"

# Buildbot irc channels
echo "Buildbot IRC channels: [$irc_channels]"
read user_irc_channels
[ ! -z "$user_irc_channels" ] && irc_channels="$user_irc_channels"

# Buildbot http port
echo "Buildbot HTTP port: [$buildbot_http_port]"
read user_buildbot_http_port
[ ! -z "$user_buildbot_http_port" ] && buildbot_http_port="$user_buildbot_http_port"

title_lower=$(echo $title | tr "[:upper:]" "[:lower:]")
master="$title-master"
slave="$title-slave"

cmd="cat $cfg_template"
cmd="$cmd | sed -e s,\{title\},'$title',g"
cmd="$cmd | sed -e s,\{title_url\},'$title_url',g"
cmd="$cmd | sed -e s,\{git_url\},'$git_url',g"
cmd="$cmd | sed -e s,\{hostname\},'$hostname',g"
cmd="$cmd | sed -e s,\{buildbot_http_port\},'$buildbot_http_port',g"
cmd="$cmd | sed -e s,\{crosscompile_dir\},'$crosscompile_dir',g"
cmd="$cmd | sed -e s,\{source_dir\},'$source_dir',g"
cmd="$cmd | sed -e s,\{www_dir\},'$www_dir',g"
cmd="$cmd | sed -e s,\{slave_name\},'$slave_name',g"
cmd="$cmd | sed -e s,\{slave_pass\},'$slave_pass',g"
cmd="$cmd | sed -e s,\{slave_port\},'$slave_port',g"
cmd="$cmd | sed -e s,\{irc_server\},'$irc_server',g"
cmd="$cmd | sed -e s,\{irc_nickname\},'$irc_nickname',g"
cmd="$cmd | sed -e s,\{irc_channels\},'$irc_channels',g"
cmd="$cmd > $master/master.cfg"
create_cfg="$cmd"

sudo apt-get -y install buildbot

sudo useradd -r -m $unix_name

sudo -u $unix_name -H sh -c "cd ~; buildbot create-master $master ; $create_cfg ; buildbot start $master"

sudo -u $unix_name -H sh -c "cd ~; buildslave create-slave $slave localhost:$slave_port $slave_name $slave_pass"

sudo -u $unix_name -H sh -c "cd ~; echo \"$admin <$admin_email>\" >$slave/info/admin ; echo $hostname >$slave/info/host"

sudo -u $unix_name -H sh -c "cd ~; buildslave start $slave"

sudo ufw insert 1 allow proto tcp to any port $buildbot_http_port
