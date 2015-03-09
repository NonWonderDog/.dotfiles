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
home directory, just like on Linux.  Explorer should show these with a link 
icon, but the link icon is fairly low priority.  If you have both TortoiseGit 
and OneDrive installed they may not show up.

