set nocompatible
syntax on
filetype on

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
au FileType javascript setl sw=2 ts=2 sts=2
au BufNewFile,BufRead *.json set filetype=json
au FileType json setl sw=2 ts=2 sts=2

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

" use system clipboard, hopefully
" http://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim
if has('mac')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" make backspace work
set backspace=2

" hybrid line numbers
set relativenumber 

" somehow a lot of stuff gets turned off when you turn on hybrid line
" numbers...
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
