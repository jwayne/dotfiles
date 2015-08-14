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
au FileType css setl sw=4 ts=4 sts=4 noexpandtab
au FileType javascript setl sw=4 ts=4 sts=4 noexpandtab
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
set clipboard=unnamedplus

" make backspace work
set backspace=2

" hybrid line numbers
set relativenumber 

" More key bindings
"http://www.techrepublic.com/blog/linux-and-open-source/create-custom-keybindings-in-vim/
