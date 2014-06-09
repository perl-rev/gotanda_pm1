"文字コード設定
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set fileformats=unix,dos,mac
"表示
colorscheme molokai
set t_Co=256

"""""""""""""""
"挿入モード時、ステータスラインの色を変更
""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx','', '')
  return hl
endfunction

"ステータスラインを常に表示
set laststatus=2
"ステータスラインに文字コードと改行コードを表示
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]
"入力
"タブを入力するとスペースに変換
set smarttab
"バックスースペース入力すると4つ削除される
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
syntax on


au BufReadPost,BufNewFile *.cgi:setl filetype=perl
set cindent

" カーソルを自動的に()の中へ
 imap {} {}<Left>
 imap [] []<Left>
 imap () ()<Left>
 imap "" ""<Left>
 imap '' ''<Left>
 imap <> <><Left>
 imap // //<left>
 imap /// ///<left>

noremap <Space>j <C-f>
noremap <Space>k <C-b>

"タブ改行を可視化
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" 全角スペース・行末のスペース・タブの可視化
if has("syntax")
    " PODバグ対策
    syn sync fromstart

    function! ActivateInvisibleIndicator()
  "下の行の"　"は全角スペース
   syntax match InvisibleJISX0208Space "　" display containedin=ALL
   highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
    endfunction
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

