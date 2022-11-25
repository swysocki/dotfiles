$dotfilePath="$HOME\devel\repos\dotfiles"

# install utilities needed by my dotfiles
winget install Git.Git
winget install WezTerm
winget install vim.vim

# clone my dotfiles
if (!(Test-Path "$dotfilePath")) {
	git clone https://github.com/swysocki/dotfiles.git $dotfilePath
	git submodule update --init
}

# create links
New-Item -Path $HOME\.wezterm.lua -ItemType HardLink -Value "$dotfilePath\wezterm.lua" -Force
New-Item -Path $HOME\_vimrc -ItemType HardLink -Value "$dotfilePath\vimrc" -Force
if (!(Test-Path "$dotfilePath\vim")) {
	New-Item -Path $HOME\vimfiles -ItemType Junction -Value "$dotfilePath\vim"
}

# Copy Powershell Profile
Copy-Item "$dotfilePath\Microsoft.PowerShell_profile.ps1" $PROFILE -Force

# install fzf
if (!(Test-Path "$HOME\.fzf")) {
	git clone --depth 1 https://github.com/junegunn/fzf.git $HOME\.fzf
	$curDir=$PWD.path
	cd $HOME\.fzf
	.\install.ps1
	cd $curDir
}
