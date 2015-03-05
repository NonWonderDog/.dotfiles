Configuration Files
===================
My Linux dotfiles... kind of.

This is actually maintained on Windows, using ConEmu and MSysGit.

I haven't tested it on actual Linux for a while.  I was using a different 
.bashrc on Linux before, and I need to make this compatible.

Install - Linux
---------------
The included shell script will back up any existing files in ~ to 
~/.dotfiles\_old, and make symlinks to the files in the ~/.dotfiles directory 
in ~.

I haven't actually tested that, mind.

Install - Windows
-----------------
On windows, run the `install.ps1` powershell script as admin.  The batch file 
`install.bat` will do this for you.  This will create symbolic links in your 
home directory, just like on Linux.  Explorer and msysgit's `ls` command do 
a terrible job communicating that these are symlinks (they just show them as 
0-byte files), but they work just as well.

