set mouse-=a
syntax on
" https://vi.stackexchange.com/questions/422/displaying-tabs-as-characters 
set list
set listchars=tab:>-
" set number

" https://www.vim.org/scripts/script.php?script_id=760
" https://github.com/vim-scripts/peaksea
" if ! has("gui_running")
"     set t_Co=256
" endif
"" feel free to choose :set background=light for a different style
" set background=dark
" colors peaksea

" https://github.com/itchyny/lightline.vim
set laststatus=2
" export TERM=xterm-256color

if !has('gui_running')
  set t_Co=256
endif

set noshowmode

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ }
