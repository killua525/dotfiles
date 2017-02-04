#/bin/bash
set -x
function help()
{
	echo "usage $0 vim/zsh";
}
function clonezsh()
{
	if [ ! -d $HOME/.oh-my-zsh ]
	then
		git clone https://github.com/jzdxeb/oh-my-zsh.git  $HOME/.oh-my-zsh
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
function vimins()
{
if [ ! -f $HOME/.vimrc ];
then 
	ln -s $PWD/config/vimrc $HOME/.vimrc  &&\
	ln -s $PWD/vim $HOME/.vim			&&\
	ln -s $PWD/config/ycm_extra_conf.py $HOME/.ycm_extra_conf.py  &&\
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
	vimins;
fi
if [ $1 = "zsh" ]
then 
	zsh
fi
}
main $*
