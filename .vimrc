execute pathogen#infect()
filetype plugin indent on 

syntax on
let g:livepreview_previewer = 'zathura'
let g:instant_markdown_autostart = 0
let g:powerline_pycmd="py3"

call vundle#begin()
" A Vim Plugin for Lively Previewing LaTeX PDF Output
Plugin 'xuhdev/vim-latex-live-preview'
call vundle#end()

call plug#begin()
Plug 'junegunn/goyo.vim'
call plug#end()

map <F6> :set spell! <CR>

" set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" " Always show statusline
" set laststatus=2

" " Use 256 colours (Use this setting only if your terminal supports 256 colours)
" set t_Co=256

let g:ycm_server_python_interpreter = '/usr/bin/python2'

set relativenumber
set clipboard=unnamedplus
set number
set title
set mouse=a
nmap , :w<Enter>
nmap . :q<Enter>
highlight LineNr ctermbg=black ctermfg=darkgrey
highlight CursorLineNr ctermbg=black ctermfg=white cterm=bold
set cursorline
highlight CursorLine cterm=NONE
nnoremap <C-t> :tabnew<cr>
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>
map <F4> ggVGg?
nnoremap <F1> :find 
map <F9> :vsp<space>~/Documents/LaTeX/college.bib<CR>


set path=.,,**
nnoremap <C-j> :tabp<CR>
nnoremap <C-k> :tabn<CR>
nnoremap <C-1> :tabfirst<CR>
" nnoremap <C-w> :tabclose<CR>
nnoremap <C-f> /<CR>
inoremap <C-b> \textbf{}<Left>
inoremap <C-n> \documentclass[12pt, letterpaper, twoside]{article}<Enter>\usepackage[utf8]{inputenc}<Enter>\title{Placement}<Enter>\author{Will Anderson}<Enter>\date{00-00-2018}<Enter><Enter>\begin{document}<Enter><Enter>\begin{titlepage}<Enter>\maketitle<Enter>\end{titlepage}<Enter>\tableofcontents<Enter><Enter><Enter><Enter>\end{document}<Up><Up>o
inoremap jj <Esc>

autocmd FileType tex inoremap <F4> \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap <F5> \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap <F6> \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap <F1> \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap <F2> \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;li <Enter>\item<Space>
autocmd FileType tex inoremap <F3> \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
autocmd FileType tex inoremap <F9> \begin{frame}<Enter><Enter><++><Enter><Enter>\end{frame}<Space><Space>
autocmd FileType tex inoremap ;fig \begin{figure}[H]<Enter><Enter><++><Enter><Enter>\end{figure}
autocmd FileType tex inoremap ;img \includegraphics[<++>]{<++>}<Space><Space>

map <leader>p :!zathura <c-r>%<backspace><backspace><backspace>pdf &<CR><CR>

map <F10> :Goyo<CR>
map <leader>f :Goyo<CR>
inoremap <F10> <esc>:Goyo<CR>a


inoremap <Space><Space> <Esc>/<++><Enter>"_c4l
vnoremap <Space><Space> <Esc>/<++><Enter>"_c4l
map <Space><Space> <Esc>/<++><Enter>"_c4l
inoremap ;gui <++>
