
=========================================
== TOC

1, install cscope and ctags
2, Indexing with scripts/tags.sh
3, or indexing manually with my script
4, vim plugins
4.1, installing cscope maps for vim
4.2, installing vim linux coding style for vim
4.3, installing NERDTree for vim
4.3, installing vimwiki for vim

=========================================
== CONTENT

1, install cscope and ctags:
	sudo aptitude install cscope exuberant-ctags

2, Indexing with scripts/tags.sh:
	$ make O=. ARCH=arm SUBARCH=omap2 COMPILED_SOURCE=1 cscope tags

	where COMPILED_SOURCE=1 - index only compiled files. You are usually
	only interested in source files used in your build (hence compiled). If
	you want to index also files that weren't built, just omit this option.

3, or indexing manually with my script.
	$ ~/bin/linus_linux_XX.sh -tc

4, vim plugins
	With pathogen plugin, we call install vim plugins into its private
	directory. See: https://github.com/tpope/vim-pathogen

	Install it with:
	$ mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

4.1, installing cscope maps for vim
	$ git clone https://github.com/joe-skb7/cscope-maps.git \
				~/.vim/bundle/cscope-maps

4.2, installing vim linux coding style for vim
	$ git clone https://github.com/vivien/vim-linux-coding-style.git  \
			~/.vim/bundle/vim-linux-coding-style

4.3, installing NERDTree for vim
	$ git clone https://github.com/scrooloose/nerdtree.git  \
			~/.vim/bundle/nerdtree

4.3, installing vimwiki for vim
	$ git clone https://github.com/vimwiki/vimwiki.git \
			~/.vim/bundle/vimwiki
	TIP: remember to put wiki content into the directory marked at dotvimrc

