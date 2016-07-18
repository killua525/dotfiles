#/bin/bash
function help()
{
	echo "usage $0 vim/zsh";
	return 0;
}
function clonezsh()
{
	if [ ! -d $HOME/.oh-my-zsh ]
	then
		git clone https://github.com/wangjianli0410/oh-my-zsh.git $HOME/.oh-my-zsh
	fi
}
function zsh()
{
if [ ! -f $HOME/.zshrc ]
then 
	clonezsh
	ln -s $PWD/zsh/zshrc $HOME/.zshrc
fi
else
	echo "file ~/.zshrc is exist"
fi
}
function vim()
{
if [ ! -f $HOME/.vimrc ];
then 
	ln -s $PWD/vim/vimrc $HOME/.vimrc
	ln -s $PWD/vim $HOME/.vim
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
else
	echo "file ~/.vimrc is exist"
fi
}
function main()
{
if [ $# != 1 ]
then 
	help;
	exit 1;
fi
if [ $1 = "vim" ]
then 
	vim;
fi
if [ $1 = "zsh" ]
then 
	zsh
fi
}
main $*
