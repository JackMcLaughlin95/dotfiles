" Lots taken from thoughtbot/dotfiles/blob/master/vimrc

set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
"let path='~/.vim/bundle'
call vundle#begin()

" let Vundle manage Vundle. required!
Plugin 'gmarik/vundle.vim'

" My Bundles here:
"
" original repos onhub
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-ruby/vim-ruby'
Plugin 'slim-template/vim-slim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-rails'
Plugin 'thoughtbot/vim-rspec'
Plugin 'jgdavey/vim-railscasts'
Plugin 'jgdavey/tslime.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-endwise'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'
Plugin 'wting/rust.vim'
Plugin 'altercation/vim-colors-solarized.gitPlugin'

" snipmate deps
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

Plugin 'garbas/vim-snipmate'
" bunch of vim snippets
Plugin 'honza/vim-snippets'

call vundle#end()
filetype plugin indent on " required!

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

set noswapfile
set cursorline
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set tags=.git/tags " path to tags file... created via git hooks. see git_template

" Display trailing  white spaces
set list listchars=tab:»·,trail:·

" Line numbers
set number
set numberwidth=5

" Colorschemes
set t_Co=256
set background=dark
colorscheme solarized

syntax on

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

imap <C-J> <Plug>snipMateNextOrTrigger

" netrw file tree
let g:netrw_list_hide= '\.DS_Store$,\.git$'

" soft tabs 2 spaces
set tabstop=2 shiftwidth=2 expandtab

" line length marker
set colorcolumn=80

" nice cursor
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Quicker window movement
 nnoremap <C-j> <C-w>j
 nnoremap <C-k> <C-w>k
 nnoremap <C-h> <C-w>h
 nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

" vim rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" rspec and tmux intergration
let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'

" Search
map <Leader>f :CtrlP<CR>
map <Leader>. :CtrlPTag<CR>

set wildmode=longest,list,full
set wildmenu

" Remove trailing white space
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" select range of lines
" e.g. :1,2Vis
command! -range Vis call setpos('.', [0,<line1>,0,0]) |
                    \ exe "normal V" |
                    \ call setpos('.', [0,<line2>,0,0])a

" And call the above on every save
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Retab on load for whitelisted file types
autocmd BufReadPost * if &modifiable | retab | endif

" Slim syntax highlighting fix
autocmd BufNewFile,BufRead *.slim set syntax=slim|set ft=slim

" Treat .es6 as .js
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

