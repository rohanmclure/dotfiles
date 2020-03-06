.PHONY: all

install: setup rmdefault link
	touch ~/.zshvars

link: .zshrc init.vim .vimrc .tmux.conf
	ln -s .zshrc ~/.zshrc 
	mkdir -p ~/.config/nvim/ && ln -s init.vim ~/.config/nvim/init.vim
	ln -s .vimrc ~/.vimrc 
	ln -s .tmux.conf ~/.tmux.conf 

rmdefault:
	ls -d ~/.zshrc && rm ~/.zshrc
	ls -d ~/.vimrc && rm ~/.vimrc
	ls -d ~/.tmux.conf && rm ~/.tmux.conf

setup: link zsh neovim tmux

zsh: link
	chmod u+x ./zshinstall && ./zshinstall

neovim: link
	# chmod u+x ./neoviminstall && ./neoviminstall

tmux: link
	# chmod u+x ./tmuxinstall && ./tmuxinstall
