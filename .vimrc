" Thiết lập cơ bản cho Vim/Nvim
set nocompatible              " Tắt chế độ tương thích với vi
filetype plugin indent on      " Kích hoạt tự động nhận diện loại file và indent
set encoding=UTF-8             " Thiết lập mã hóa UTF-8

" Thêm thư mục plugin vào runtimepath
set rtp+=~/.vim/bundle/Vundle.vim

" Kích hoạt Vundle và cấu hình plugin
call vundle#begin()

" Plugin quản lý
Plugin 'VundleVim/Vundle.vim'

" Các plugin cơ bản
Plugin 'tpope/vim-sensible'         " Một cấu hình Vim hợp lý
Plugin 'scrooloose/nerdtree'        " File explorer
Plugin 'junegunn/fzf.vim'           " Fuzzy finder
Plugin 'itchyny/lightline.vim'      " Lightweight statusline
Plugin 'vim-airline/vim-airline'    " Statusline
Plugin 'tpope/vim-fugitive'         " Git integration
Plugin 'dense-analysis/ale'         " Linter/Formatter
Plugin 'mattn/emmet-vim'            " HTML/CSS Snippets

" Hỗ trợ PHP
Plugin 'phpactor/phpactor'          " PHP Refactoring tools
Plugin 'StanAngeloff/php.vim'       " PHP syntax
Plugin 'neomake/neomake'            " Async syntax checking and linting
Plugin 'scrooloose/syntastic'       " Syntax checking

" Hỗ trợ front-end
Plugin 'ap/vim-css-color'           " Hiển thị màu sắc từ mã màu trong CSS
Plugin 'jiangmiao/auto-pairs'       " Tự động đóng dấu ngoặc
Plugin 'prettier/vim-prettier', { 'do': 'npm install' } " Prettier formatter

" Các plugin khác
Plugin 'morhetz/gruvbox'            " Màu sắc Gruvbox
Plugin 'preservim/nerdcommenter'     " Bình luận code dễ dàng
Plugin 'ryanoasis/vim-devicons'      " Icons cho NERDTree

" Kết thúc phần cấu hình plugin
call vundle#end()

" Cấu hình Prettier cho Vim
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 0
let g:prettier#config#single_quote = 1
let g:prettier#config#trailing_comma = 'es5'
let g:prettier#config#jsx_bracket_same_line = 0

" Autocommand cho PHP và các file khác
autocmd FileType php setlocal expandtab shiftwidth=4 softtabstop=4
autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.json,*.css,*.html PrettierAsync

" Các thiết lập tab và định dạng
set tabstop=4
set shiftwidth=4
set number

" Cấu hình Gruvbox
let g:gruvbox_contrast_dark = 'soft' " Có thể là 'soft', 'medium', hoặc 'hard'
colorscheme gruvbox

" Lệnh để chạy mã PHP
command! RunPHP :w !php %
command! RunC :w !gcc -o %< % && ./%<
command! RunPYTHON :w !python3 %
command! RunHTML :w !xdg-open "%:p"
command! -nargs=1 OpenImage execute 'silent !xdg-open ' . shellescape(<q-args>)

" Tùy chỉnh lệnh phím
nnoremap <leader>w :RunHTML<CR>
nnoremap <leader>h :RunPHP<CR>
nnoremap <leader>c :RunC<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>p :RunPYTHON<CR>
nnoremap <F1> <Esc>
imap <F1> <Esc>

vnoremap <C-c> :w !xsel -i -b<CR> 

"
" Phím tắt để bật tắt trong suốt
let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_transparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>

" Mapping cho NERDTree để copy đường dẫn file
autocmd FileType nerdtree nnoremap <buffer> yy :call NERDTreeYankCurrentNode()<CR>
function! NERDTreeYankCurrentNode()
    let n = g:NERDTreeFileNode.GetSelected()
    if n != {}
        call setreg('"', n.path.str())
    endif
endfunction

