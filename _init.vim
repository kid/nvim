set guifont=Fira\ Code\ Nerd\ Font:h11

luafile ~/.config/nvim/config.lua

set complete-=t
set timeoutlen=500

autocmd FileType help wincmd L
autocmd FileType NvimTree setlocal nowrap signcolumn=no
autocmd FileType markdown setlocal spell
autocmd TermOpen * setlocal nonumber norelativenumber nowrap signcolumn=no
" autocmd FileType rust lua require'lsp_extensions'.inlay_hints{}

" Reload files after C-z
autocmd VimResume * silent! checktime

autocmd BufEnter,BufWinEnter,TabEnter *.rs lua require'lsp_extensions'.inlay_hints{}

let mapleader = "\<Space>"
let maplocalleader = "\\"

nnoremap <silent> <leader> <cmd><c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> <cmd><c-u>WhichKeyVisual '<Space>'<CR>

nnoremap <silent> <localleader> <cmd><c-u>WhichKey '\'<CR>
vnoremap <silent> <localleader> <cmd><c-u>WhichKeyVisual '\'<CR>

map <leader><leader> <cmd>Files<cr>
map <space>, <cmd>Buffers<cr>
map <space>h <cmd>Helptags<cr>

imap jk <esc>
imap kj <esc>
vmap jk <esc>
vmap kj <esc>

" Use <C-s> for save
nnoremap <silent> <C-s> <cmd>update<cr>
inoremap <silent> <C-s> <cmd>update<cr>
vnoremap <silent> <C-s> <cmd>update<cr>

" Allow <C-z> from insert mode and visual modes
inoremap <silent> <C-z> <cmd>stop<cr>
vnoremap <silent> <C-z> <cmd>stop<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" imap <tab>   <Plug>(completion_smart_tab)
" imap <s-tab> <Plug>(completion_smart_s_tab)

" Copy til end if one, like C and D
nnoremap Y y$

" System copy paste
nnoremap <Leader>y "+y
nnoremap <Leader>Y "+y$
vnoremap <Leader>y "+y

nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p

" vim-cutlass bindings
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-k>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'
smap <expr> <C-k>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'

" Jump forward or backward
" imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')

nnoremap <silent> <leader>b :BufferLinePick<CR>

nnoremap <silent>tn :tabnew<CR>
nnoremap <silent>[t :tabprev<CR>
nnoremap <silent>]t :tabnext<CR>
nnoremap <silent>[b :BufferLineCyclePrev<CR>
nnoremap <silent>]b :BufferLineCycleNext<CR>
nnoremap <silent>[d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent>]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gtd   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <leader>ca     <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>cf     <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>cr     <cmd>lua vim.lsp.buf.rename()<CR>

" Move to word
map <LocalLeader><LocalLeader> <Plug>(easymotion-prefix)
map  <LocalLeader><LocalLeader>w <Plug>(easymotion-bd-w)
nmap <LocalLeader><LocalLeader>w <Plug>(easymotion-overwin-w)

" Navigation between windows
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Using floating windows of Neovim to start fzf
if has('nvim-0.4.0')
  " let $FZF_DEFAULT_OPTS .= '--color=bg:#20242C --border --layout=reverse'
  let $FZF_DEFAULT_OPTS .= '--layout=reverse'

  " function! FloatingFZF()
  "   let width = float2nr(&columns * 0.9)
  "   let height = float2nr(&lines * 0.6)
  "   let opts = {
  "   \ 'relative': 'editor',
  "   \ 'row': (&lines - height) / 2,
  "   \ 'col': (&columns - width) / 2,
  "   \ 'width': width,
  "   \ 'height': height,
  "   \ 'style': 'minimal'
  "   \ }

  "   let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  "   call setwinvar(win, '&winhighlight', 'NormalFloat:TabLine')
  " endfunction

  " let g:fzf_layout = { 'window': 'call FloatingFZF()' }
  " let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'CursorLine' } }
  let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5 } }
  " let g:fzf_colors =
  "   \ { 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  "   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'] }
endif

let g:completion_customize_lsp_label = {
      \ 'Function': ' [function]',
      \ 'Method': ' [method]',
      \ 'Reference': ' [refrence]',
      \ 'Enum': ' [enum]',
      \ 'Field': 'ﰠ [field]',
      \ 'Keyword': ' [key]',
      \ 'Variable': ' [variable]',
      \ 'Folder': ' [folder]',
      \ 'Snippet': ' [snippet]',
      \ 'Operator': ' [operator]',
      \ 'Module': ' [module]',
      \ 'Text': 'ﮜ[text]',
      \ 'Class': ' [class]',
      \ 'Interface': ' [interface]'
      \}

" highlight! link LspDiagnosticsUnderlineError CocErrorHighlight
" highlight! link LspDiagnosticsUnderlineHint CocHintHighlight
" highlight! link LspDiagnosticsUnderlineInfo CocInfoHighlight
" highlight! link LspDiagnosticsUnderlineWarning CocWarningHighlight

nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeToggle<CR>

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=20

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

set sw=2
set ts=2
set expandtab
