#/bin/bash
function help()
{
	echo "usage $0 vim/zsh";
}
function clonezsh()
{
	if [ ! -d $HOME/.oh-my-zsh ]
	then
		git clone git@github.com:jzdxeb/oh-my-zsh.git  $HOME/.oh-my-zsh
	fi
}
function zsh()
{
if [ ! -f $HOME/.zshrc ]
then 
	clonezsh && \
	ln -s $PWD/config/zshrc $HOME/.zshrc
else
	echo "file ~/.zshrc is exist"
fi
}
function vim()
{
if [ ! -f $HOME/.vimrc ];
then 
	ln -s $PWD/config/vimrc $HOME/.vimrc  &&\
	ln -s $PWD/vim $HOME/.vim			&&\
	git clone git@github.com:jzdxeb/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&\
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
	exit 0;
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
