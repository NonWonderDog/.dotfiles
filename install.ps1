# Read the MATLAB path definition file, and add lines immediately before the
# default MATLAB paths.

## Helper Functions
function pauseQuit
{
    # If running in the console, wait for input before closing.
    if ($Host.Name -eq "ConsoleHost") {
        write-host ""
        write-host "Press any key to continue..."
        $Host.UI.RawUI.FlushInputBuffer()
        $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
    }
    exit
}

## Main Program
$dir = get-item -Force (split-path -parent $MyInvocation.MyCommand.Path)
$files = @("bash_profile","bashrc","bash_aliases","inputrc","ctags","gitconfig","ghci","tmux.conf","minttyrc","config\fish\config.fish")
$folders = @("tmux","config\fish\functions")
$olddir = join-path $HOME .dotfiles_old

# create dotfiles_old in home dir
mkdir $olddir -Force > null

# move any existing dotfiles in homedir to dotfiles_old directory, then create 
# symlinks from the homedir to any files in the ~/.dotfiles directory specified 
# in $files
write-host "Moving any existing dotfiles from $HOME to $olddir"
foreach ($file in $files) {
    if (test-path "$HOME\.$file") {
        move-item "$HOME\.$file" $olddir
    }
}
foreach ($folder in $folders) {
    if (test-path "$HOME\.$folder") {
        move-item "$HOME\.$folder" $olddir
    }
}

foreach ($file in $files) {
    echo "cmd /c mklink ""$HOME\.$file"" ""$dir\home\$file"""
    cmd /c mklink "$HOME\.$file" "$dir\home\$file"
}

foreach ($folder in $folders) {
    cmd /c mklink /D "$HOME\.$folder" "$dir\home\$folder"
}

## Extra installs for Windows-specific files
# native ghci uses %APPDATA%/ghc/ghci.conf instead of ~/.ghci
cmd /c mklink "$env:APPDATA\ghc\ghci.conf" "$dir\home\ghci"
# ConEmu config goes in %APPDATA%
cmd /c mklink "$env:APPDATA\ConEmu.xml" "$dir\ConEmu.xml"

write-host "Done."
pauseQuit

