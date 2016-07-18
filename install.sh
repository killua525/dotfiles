#/bin/bash
function help()
{
	echo "usage $0 vim/zsh";
	return 0;
}
function clonedotfile()
{
	if [ ! -d $HOME/.dotfiles  ]
	then
		git clone https://github.com/wangjianli0410/dotfiles.git $HOME/.dotfiles
	fi
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
if [ ! -a $HOME/.zshrc ]
then 
	clonedotfile
	clonezsh
	ln -s $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
fi
return 0;
}
function vim()
{
if [ ! -a $HOME/.vimrc ];
then 
	clonedotfile
	ln -s $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
	ln -s $HOME/.dotfiles/vim $HOME/.vim
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
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
#rm ~/.zshrc
#ln -s $PWD/zsh/zshrc ~/.zshrc
#fuction vim()
#{
#	echo vim;
#	return 0;
#}
#fuction zsh()
#{
#	echo vim;
#	return 0;
#}
main $*
