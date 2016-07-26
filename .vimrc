" Following lines added by drush vimrc-install on Thu, 20 Aug 2015 05:16:47 +0000.
set nocompatible
call pathogen#infect('/home/samb/.drush/vimrc/bundle/{}')
call pathogen#infect('/home/samb/.vim/bundle/{}')
" End of vimrc-install additions.
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'
" Auto complete with supertab!
Plugin 'ervandew/supertab'
" Muuuch better PHP autocompletion than default in ViM
Plugin 'shawncplus/phpcomplete.vim'
" Gimme class and function outlines
Plugin 'majutsushi/tagbar'
" Drupal plugin
Bundle 'git://drupalcode.org/project/vimrc.git', {'rtp': 'bundle/vim-plugin-for-drupal/'}
" Syntax highlighting for twig
Plugin 'evidens/vim-twig'
" File browser in ViM? Whaaaat!
Plugin 'scrooloose/nerdtree'
" Improved javascript highlighting
Plugin 'jelera/vim-javascript-syntax'
" Powerline, cause its even awesomer than my homebrewed one!
Plugin 'Lokaltog/vim-powerline'
"CoffeeScript Support
Plugin 'kchmck/vim-coffee-script'
" Match HTML tags
Plugin 'gregsexton/MatchTag'
" Comment multiple lines (there must be a way to do this without a plugin!)
Plugin 'scrooloose/nerdcommenter'
" Better snipmate that works with supertab
Plugin 'garbas/vim-snipmate'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
" Fuzzy finder
Plugin 'kien/ctrlp.vim'
" Debugging for pros
Plugin 'joonty/vdebug'
" Syntax checking!
Plugin 'scrooloose/syntastic'
" Better python support
Plugin 'klen/python-mode'
" Ag support
"Plugin 'rking/ag.vim'

" Add fzf for fuzzy finding.
set rtp+=~/.fzf

" Supertab config
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
highlight   clear
highlight   Pmenu         ctermfg=0 ctermbg=2
highlight   PmenuSel      ctermfg=0 ctermbg=7
highlight   PmenuSbar     ctermfg=7 ctermbg=0
highlight   PmenuThumb    ctermfg=0 ctermbg=7

" TagBar config
nmap <F8> :TagbarToggle<CR>
let g:tagbar_show_visibility = 1
let g:tagbar_width = 55
let g:tagbar_sort = 0
let g:tagbar_show_linenumbers = -1
let g:tagbar_singleclick = 1
" Open tagbar automatically when file is supported
autocmd VimEnter * nested :call tagbar#autoopen(1)

" Nerdtree config
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=50

set number

" Set encoding to UTF-8 cause, why the hell wouldn't you?
set encoding=utf-8

" For now, I want mouse support, and I also want to be able to copy to the ubuntu
" clip board. This needs vim-gnome package to function
set mouse=a
set clipboard=unnamed
"set cc=80
hi ColorColumn ctermbg=lightgrey guibg=lightgrey

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

set nocompatible " get out of horrible vi-compatible mode
filetype on " detect the type of file
set history=10000 " How many lines of history to remember
"set clipboard+=unnamed " turns out I do like clipboard
set ffs=unix,dos,mac " support all three, in this order
filetype plugin on " load filetype plugins
set viminfo+=! " make sure it can save viminfo

" automatically remove trailing whitespace before write
function! StripTrailingWhitespace()
  normal mZ
  %s/\s\+$//e
  if line("'Z") != line(".")
    echo "Stripped whitespace\n"
  endif
  normal `Z
endfunction
autocmd BufWritePre *.module,*.install,*.inc,*.php :call StripTrailingWhitespace()

" Highlight redundant whitespaces and tabs.
:highlight RedundantSpaces ctermbg=red guibg=red
:match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

" Highlighting long comment lines
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\(^\(\s\)\{-}\(*\|//\|/\*\)\{1}\(.\)*\(\%81v\)\)\@<=\(.\)\{1,}$'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme/Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on " syntax highlighting on
set background=dark " we are using a dark background
"Compat mode for solarized, I'm not switching my entire terminal color pallete
"run export TERM=xterm-256color in the terminal to make things look right
let g:solarized_termcolors=256
colorscheme solarized

"set lsp=1 " space it out a little more (easier to read)
"set wildmenu " turn on wild menu
set ruler " Always show current positions along the bottom 
set cmdheight=1 " the command bar is 1 high
"set lz " do not redraw while running macros (much faster) (LazyRedraw)
set shortmess=atI " shortens messages to avoid 'press a key' prompt 
set report=0 " tell us when anything is changed via :...
set noerrorbells " don't make noise

""""""
" kick-ass statusline
""""""
 function! CurDir()
     let curdir = substitute(getcwd(), '/home/samb', "~/", "g")
     return curdir
  endfunction
  "Format the statusline
  set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L\ Column:\%c

"""""""""""""""""""""""""""""""""""""""
" Misc stuff to do that makes sense
"""""""""""""""""""""""""""""""""""""""
set nobackup " turn off file backup,
set noswapfile
set laststatus=2 " always show the status line
set nowrap " do not wrap lines
" I keep typing :Q! instead of :q! and it's fucking annoying
" this fixes it ;)
command -bang -bar Q :q<bang>
"this is some more visual tweaking, but i can't be fucked moving it up
" lets comments look the same
"set comments+=b:\"
"set comments+=n::
"set comments+=b:#

""""""""""""""""""""""""""""""""""""""
" Drupal/PHP Stuff
""""""""""""""""""""""""""""""""""""""
"syntax on gives us syntax highlighting
"set nostartofline

"syntax highlighting inside php sql queries
let php_sql_query = 1

"set the spaces instead of regular tab
set expandtab

"sets tab and shiftwidth to 2 spaces according to drupals coding standard
set tabstop=2 shiftwidth=2

"give filenames with .inc, .module and .php the php syntax highlighting 
autocmd BufRead .inc,.module,.install,.test set ft=php

"use the same indent from current line when starting a new line
set autoindent

"use smart autoindenting. Used when line ends with {
set smartindent

"sets vim in pastemode and you avoid unwanted sideeffects
"set paste
set mouse=a

"the incremental search gives us matching words as you type.
set incsearch

"the highlight search will highlight all matchings, and you can browse the document to see all matches
set hlsearch

"noremap <buffer> <F2>#d<CR> :source ~/.drupal_vim/.drupal.vimrc<CR>
" Remap :b# (re-open last file in buffer) to ctrl e
nmap <C-e> :e#<CR>

" Remember my last place in a file plz
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif  

" CtrlP config
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
