# GIT
## Install
```shell
sudo apt-get update
sudo apt-get install git
```
## Configuration
```shell
git config --global color.ui true
git config --global user.name "David Cuadra"
git config --global user.email "dcuadraq@gmail.com"
ssh-keygen -t rsa -b 4096 -C "dcuadraq@gmail.com"
cat ~/.ssh/id_rsa.pub
```
Copy the output and paste it on [your GitHub account](https://github.com/settings/keys)

# Copy repo

Assuming the the path to place the repo is `~/workspaces/dot-files/`

```shell
cd 
mkdir workspaces
cd workspaces
git clone https://github.com/dcuadraq/dot-files.git
cd dot-files
```

# Set files on HOME

Make a symbolic link on $HOME for the files
```shell
ln -s {~/workspaces/dot-files/,~/}.vimrc
ln -s {~/workspaces/dot-files/,~/}.tmux.conf
```
To replace an already existing file on $HOME
```shell
rm ~/.bashrc && ln -s {~/workspaces/dot-files/,~/}.bashrc
```
Depending on the OS, it could be `.bash_profile` instead of `.bashrc`

# VIM
## Folders for tmp and swap files
```shell
cd ~/.vim/
mkdir tmp && cd tmp
mkdir swap
mkdir undo
```

## Install vim-plug
`curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

Inside vim
```vim
:PlugInstall
```

# Gnome Plugins
* Alt Tab Workspace
* AlternateTab
* OpenWeather
* Refresh Wifi Connections
* Workspace Indicator
* Top Panel Workspace Scroll
* shellshape

# Rails
https://gorails.com/setup/

# Others
Set CAPS LOCKS as CTRL
