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
icon, as if they were shortcuts.

The Haskell interpreter ghci doesn't read the `$HOME/.ghci` file except when 
run from a Unix shell.  In order to allow ghci to be run from the windows 
command shell (which is recommended due to Control-C issues), a link to 
`.dotfiles\ghci` will also be made at `%APPDATA%\ghc\ghci.conf`.

