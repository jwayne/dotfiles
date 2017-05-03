set nocompatible

"
" Begin Vundle plugin stuff
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" To install plugins:
" Option 1: Launch vim and run :PluginInstall
" Option 2: To install from command line: vim +PluginInstall +qall
"
" see :h vundle for more details or wiki for FAQ
" https://github.com/VundleVim/Vundle.vim
"
if v:version >= 700
    try
        filetype off

        " set the runtime path to include Vundle and initialize
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()

        Plugin 'Vimjas/vim-python-pep8-indent'

        " All of your Plugins must be added before the following line
        call vundle#end()

        filetype plugin indent on
    catch
    endtry
endif
"
" End Vundle plugin stuff
"

syntax on

" indentation options
set smartindent
set shiftwidth=4
set tabstop=4
set sts=4
set expandtab
" special indentation options
au FileType html setl sw=2 ts=2 sts=2
au FileType htmldjango setl sw=2 ts=2 sts=2
au FileType css setl sw=2 ts=2 sts=2
au FileType scss setl sw=2 ts=2 sts=2
au FileType javascript setl sw=4 ts=4 sts=4
au BufNewFile,BufRead *.json set filetype=json
au FileType json setl sw=4 ts=4 sts=4

" turn off indentation for pasting code via keyboard shortcut
set pastetoggle=<F2>

" allow toggling between tabs and spaces
function TabToggle()
  if &expandtab
    set noexpandtab
  else
    set expandtab
  endif
endfunction
nmap <F3> mz:execute TabToggle()<CR>'z

" plugins
filetype plugin indent on

" use system clipboard when yanking and pasting in vim
if has('mac')
    " https://coderwall.com/p/j9wnfw/vim-tmux-system-clipboard
    set clipboard=unnamed
else
    " http://vi.stackexchange.com/a/89
    set clipboard=unnamedplus
endif
" http://superuser.com/a/389890/300511
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" make backspace work
set backspace=2

" no hybrid line numbers
" somehow a lot of stuff gets turned off when you turn on hybrid line
" numbers...
set number 

" search highlighting
set hlsearch
" jumping to last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
" line/column numbers
set ruler

" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" For editing crontab
autocmd filetype crontab setlocal nobackup nowritebackup

" More key bindings
" http://www.techrepublic.com/blog/linux-and-open-source/create-custom-keybindings-in-vim/

" Get rid of ex mode, which I accidentally enter way too often
map q: <nop>
map q/ <nop>
map q? <nop>
nnoremap Q <nop>
