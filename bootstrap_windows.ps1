# install utilities needed by my dotfiles

winget install Git.Git
winget install WezTerm
winget install Vim

# clone my dotfiles
git clone https://github.com/swysocki/dotfiles.git $HOME/devel/repos/dotfiles
git submodule update --init

# create links
New-Item -Path $HOME\.wezterm.lua -ItemType HardLink -V $HOME\Devel\Repos\dotfiles\wezterm.lua
New-Item -Path $HOME\_vimrc -ItemType HardLink -V $HOME\Devel\Repos\dotfiles\vimrc
New-Item -Path $HOME\vimfiles -ItemType Junction -V $HOME\Devel\Repos\dotfiles\vim

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$curDir=$PWD.path
cd $HOME\.fzf
.\install.ps1
cd $curDir

