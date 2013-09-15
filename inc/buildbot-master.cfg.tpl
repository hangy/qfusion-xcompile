# -*- python -*-
# ex: set syntax=python:

# This is a sample buildmaster config file. It must be installed as
# 'master.cfg' in your buildmaster's base directory.

# This is the dictionary that the buildmaster pays attention to. We also use
# a shorter alias to save typing.
c = BuildmasterConfig = {}

####### BUILDSLAVES

# The 'slaves' list defines the set of recognized buildslaves. Each element is
# a BuildSlave object, specifying a unique slave name and password.  The same
# slave name and password must be configured on the slave.
from buildbot.buildslave import BuildSlave
c['slaves'] = [BuildSlave("{slave_name}", "{slave_pass}")]

# 'slavePortnum' defines the TCP port to listen on for connections from slaves.
# This must match the value configured into the buildslaves (with their
# --master option)
c['slavePortnum'] = {slave_port}

####### CHANGESOURCES

# the 'change_source' setting tells the buildmaster how it should find out
# about source code changes.  Here we point to the buildbot clone of pyflakes.

#from buildbot.changes.gitpoller import GitPoller
#c['change_source'] = GitPoller(
#        '{git_url}',
#        workdir='gitpoller-workdir', branch='master',
#        pollinterval=300)

####### SCHEDULERS

# Configure the Schedulers, which decide how to react to incoming changes.  In this
# case, just kick off a 'runtests' build

#from buildbot.schedulers.basic import SingleBranchScheduler
#from buildbot.changes import filter
c['schedulers'] = []
#c['schedulers'].append(SingleBranchScheduler(
#                            name="all",
#                            change_filter=filter.ChangeFilter(branch='master'),
#                            treeStableTimer=None,
#                            builderNames=["runtests"]))

####### BUILDERS

# The 'builders' list defines the Builders, which tell Buildbot how to perform a build:
# what steps, and which slaves can execute them.  Note that any particular build will
# only take place on one slave.

from buildbot.steps import source, shell
from buildbot.process import factory
from buildbot.steps.source import Git
from buildbot.steps.transfer import FileUpload
from buildbot.steps.master import MasterShellCommand
from buildbot.process.properties import WithProperties

build_dir = 'build/'
cross_compile_dir = '{crosscompile_dir}'
source_dir = '{source_dir}'
www_dir = '{www_dir}'
project_git = Git(repourl='{git_url}', haltOnFailure=1)

f_win32_x86 = factory.BuildFactory()
f_win32_x86.addStep(project_git)
f_win32_x86.addStep(shell.ShellCommand(name='libs', haltOnFailure=1, command=['/bin/sh', '-c', './compile_libs.sh win32 x86'], workdir=build_dir + cross_compile_dir))
f_win32_x86.addStep(shell.ShellCommand(name='source', haltOnFailure=1, command=['/bin/sh', '-c', './compile_source.sh win32 x86'], workdir=build_dir + cross_compile_dir))
f_win32_x86.addStep(shell.ShellCommand(name='tgz', haltOnFailure=1, command=['tar', '-pczf', 'win32_x86_release.tar.gz', 'release/'], workdir=build_dir + source_dir))
f_win32_x86.addStep(FileUpload(slavesrc=source_dir + 'win32_x86_release.tar.gz', masterdest=www_dir + 'win32_x86_release.tar.gz', haltOnFailure=1, mode=0644))
b_win32_x86 = {'name': 'win32_x86', 'slavename': '{slave_name}', 'builddir': 'win32_x86', 'factory': f_win32_x86, }

f_win32_x64 = factory.BuildFactory()
f_win32_x64.addStep(project_git)
f_win32_x64.addStep(shell.ShellCommand(name='libs', haltOnFailure=1, command=['/bin/sh', '-c', './compile_libs.sh win32 x64'], workdir=build_dir + cross_compile_dir))
f_win32_x64.addStep(shell.ShellCommand(name='source', haltOnFailure=1, command=['/bin/sh', '-c', './compile_source.sh win32 x64'], workdir=build_dir + cross_compile_dir))
f_win32_x64.addStep(shell.ShellCommand(name='tgz', haltOnFailure=1, command=['tar', '-pczf', 'win32_x64_release.tar.gz', 'release/'], workdir=build_dir + source_dir))
f_win32_x64.addStep(FileUpload(slavesrc=source_dir + 'win32_x64_release.tar.gz', masterdest=www_dir + 'win32_x64_release.tar.gz', haltOnFailure=1, mode=0644))
b_win32_x64 = {'name': 'win32_x64', 'slavename': '{slave_name}', 'builddir': 'win32_x64', 'factory': f_win32_x64, }

f_lin_x86 = factory.BuildFactory()
f_lin_x86.addStep(project_git)
f_lin_x86.addStep(shell.ShellCommand(name='libs', haltOnFailure=1, command=['/bin/sh', '-c', './compile_libs.sh lin x86'], workdir=build_dir + cross_compile_dir))
f_lin_x86.addStep(shell.ShellCommand(name='source', haltOnFailure=1, command=['/bin/sh', '-c', './compile_source.sh lin x86'], workdir=build_dir + cross_compile_dir))
f_lin_x86.addStep(shell.ShellCommand(name='tgz', haltOnFailure=1, command=['tar', '-pczf', 'lin_x86_release.tar.gz', 'release/'], workdir=build_dir + source_dir))
f_lin_x86.addStep(FileUpload(slavesrc=source_dir + 'lin_x86_release.tar.gz', masterdest=www_dir + 'lin_x86_release.tar.gz', haltOnFailure=1, mode=0644))
b_lin_x86 = {'name': 'lin_x86', 'slavename': '{slave_name}', 'builddir': 'lin_x86', 'factory': f_lin_x86, }

f_lin_x64 = factory.BuildFactory()
f_lin_x64.addStep(project_git)
f_lin_x64.addStep(shell.ShellCommand(name='libs', haltOnFailure=1, command=['/bin/sh', '-c', './compile_libs.sh lin x64'], workdir=build_dir + cross_compile_dir))
f_lin_x64.addStep(shell.ShellCommand(name='source', haltOnFailure=1, command=['/bin/sh', '-c', './compile_source.sh lin x64'], workdir=build_dir + cross_compile_dir))
f_lin_x64.addStep(shell.ShellCommand(name='tgz', haltOnFailure=1, command=['tar', '-pczf', 'lin_x64_release.tar.gz', 'release/'], workdir=build_dir + source_dir))
f_lin_x64.addStep(FileUpload(slavesrc=source_dir + 'lin_x64_release.tar.gz', masterdest=www_dir + 'lin_x64_release.tar.gz', haltOnFailure=1, mode=0644))
b_lin_x64 = {'name': 'lin_x64', 'slavename': '{slave_name}', 'builddir': 'lin_x64', 'factory': f_lin_x64, }

c['builders'] = [b_win32_x86, b_win32_x64, b_lin_x86, b_lin_x64]

####### STATUS TARGETS

# 'status' is a list of Status Targets. The results of each build will be
# pushed to these targets. buildbot/status/*.py has a variety to choose from,
# including web pages, email senders, and IRC bots.

c['status'] = []

from buildbot.status import html
from buildbot.status.web import authz
authz_cfg=authz.Authz(
    # change any of these to True to enable; see the manual for more
    # options
    gracefulShutdown = False,
    forceBuild = True, # use this to test your slave once it is set up
    forceAllBuilds = False,
    pingBuilder = False,
    stopBuild = False,
    stopAllBuilds = False,
    cancelPendingBuild = False,
)
c['status'].append(html.WebStatus(http_port=8010, authz=authz_cfg))

from buildbot.status import words
irc = words.IRC("{irc_server}", "{irc_nickname}",
     channels=["{irc_channels}"],
     password="",
     allowForce=True,
     notify_events={
       'exception': 1,
       'finished': 1
     })
c['status'].append(irc)

####### PROJECT IDENTITY

# the 'title' string will appear at the top of this buildbot
# installation's html.WebStatus home page (linked to the
# 'titleURL') and is embedded in the title of the waterfall HTML page.

c['title'] = "{title}"
c['titleURL'] = "{title_url}"

# the 'buildbotURL' string should point to the location where the buildbot's
# internal web server (usually the html.WebStatus page) is visible. This
# typically uses the port number set in the Waterfall 'status' entry, but
# with an externally-visible host name which the buildbot cannot figure out
# without some help.

c['buildbotURL'] = "http://{hostname}:8010/"

####### DB URL

# This specifies what database buildbot uses to store change and scheduler
# state.  You can leave this at its default for all but the largest
# installations.
c['db_url'] = "sqlite:///state.sqlite"
