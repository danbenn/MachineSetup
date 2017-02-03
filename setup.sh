# Install vundle before loading new vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

mv .vimrc ~/
mv .bashrc ~/
mv .tmux.conf ~/
source ~/.bashrc
cd ..
rm -rf setup
