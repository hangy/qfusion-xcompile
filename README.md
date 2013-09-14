qfusion-xcompile
================

Initialize cross-compilation environment in a few steps.

You'll need a fresh x86_64 Ubuntu 12.04 VM, git and sudo privileges.

Clone this repository and run the interactive xcompile-setup.sh script.

Along with automatically installing compilation dependencies and tools, 
the scripts also sets up an IRC buildbot, which will join server and
channels of your choice.

Compiled files are copied by the buildbot to ~www/bin by default.
