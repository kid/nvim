nmap <BS> <C-W
set guifont=Fira\ Code\ Nerd\ Font:12

luafile ~/.config/nvim/init.lua

set complete-=t

autocmd FileType help wincmd L
autocmd FileType LuaTree setlocal signcolumn=no

map <space><space> :GFiles<cr>
map <space>, :Buffers<cr>

" Mapping selecting mappings
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" You can use other key to expand snippet.
" imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" imap <C-j> <Plug>(vsnip-jump-next)
" smap <C-j> <Plug>(vsnip-jump-next)
" imap <C-k> <Plug>(vsnip-jump-prev)
" smap <C-k> <Plug>(vsnip-jump-prev)


" Using floating windows of Neovim to start fzf
if has('nvim-0.4.0')
  " let $FZF_DEFAULT_OPTS .= '--color=bg:#20242C --border --layout=reverse'
  let $FZF_DEFAULT_OPTS .= '--border --layout=reverse'

  function! FloatingFZF()
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.6)
    let opts = {
    \ 'relative': 'editor',
    \ 'row': (&lines - height) / 2,
    \ 'col': (&columns - width) / 2,
    \ 'width': width,
    \ 'height': height,
    \ 'style': 'minimal'
    \ }

    let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:TabLine')
  endfunction

let g:fzf_layout = { 'window': 'call FloatingFZF()' }
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

call sign_define("LspDiagnosticsErrorSign", {"text" : ">>", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "⚡", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "", "texthl" : "LspDiagnosticsWarning"})


nnoremap <C-n> :LuaTreeToggle<CR>
nnoremap <leader>r :LuaTreeRefresh<CR>
nnoremap <leader>n :LuaTreeFindFile<CR>
