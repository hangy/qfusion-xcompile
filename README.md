qfusion-xcompile
================

Initialize cross-compilation environment in a few steps.

You'll need a fresh x86_64 Ubuntu 12.04 VM, git and sudo privileges.

Clone this repository and run the interactive xcompile-setup.sh script.

Along with automatically installing compilation dependencies and tools, 
the scripts also sets up an IRC buildbot, which will join server and
channels of your choice.

By default, compiled files are uploaded by buildbot to master's 
public_html/bin directory.

If you have qfusion imported as a submodule or a sub-tree, then you
probably going to need to prefix cross compilation and source paths
and also use sparse git checkouts.

For example, if qfusion source code is contained within the 
'sdk/source' directory of your project, run the interactive setup 
script and specify the following settings:

Cross compilation toolset directory:
sdk/source/tools/cross_compile/

Source code directory:
sdk/source/source/

Since you probably don't need full git clone of your project to build
qfusion, you can change your build slaves to use sparse git checkouts.
After a slave completes the first build (or at least initializes the
git repository), issue the following commands:

git config core.sparsecheckout true
echo sdk/source/ >> .git/info/sparse-checkout
git read-tree -mu HEAD

