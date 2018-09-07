# Install vundle before loading new vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "WARNING: this will permanently overwrite your current Vim/Tmux/Bash/Zsh settings"
read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # FORCE Link files in this repo with the configuration files
    ln -f .vimrc ~/.vimrc
    ln -f .bashrc ~/.bashrc
    ln -f .zshrc ~/.zshrc
    ln -f .tmux.conf ~/.tmux.conf

    # Update the current shell with these preferences
    source ~/.bashrc
fi
