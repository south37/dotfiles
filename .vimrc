set incsearch
set hlsearch
" 検索結果のハイライトはさりげなく消す
" 参考: https://github.com/TEVASAKI/dotfiles/blob/master/vimrc
nnoremap <Esc><Esc>  :<C-u>nohlsearch<CR>

set expandtab
set tabstop=8
set shiftwidth=2
set softtabstop=0

set autoindent
set smartindent

" 折り返さない
set nowrap

" アンダースコアもwordの区切り文字として認識
" 参考: http://qiita.com/shuhei/items/b1052736116055be7d7b
" set iskeyword-=_

syntax on
set showcmd
set number
set clipboard=autoselect
set clipboard+=unnamed

" backspaceを有効にする
" 参考: http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=2 " make backspace work like most other apps
set backspace=indent,eol,start

" 移動は見た目の行で
nnoremap j gj
nnoremap k gk

" Gemfileをruby modeで開く
au BufNewFile,BufRead Gemfile setf ruby
" jbuilderをruby modeで開く
au BufNewFile,BufRead jbuilder setf ruby
" Treat .rbi as rb
autocmd BufRead,BufNewFile *.rbi setfiletype ruby

" rbファイルを開いた時は、デフォルトでマジックコメント追加
"autocmd BufNewFile *.rb 0r ~/.vim/templates/rb.tpl



" 末尾の空白スペースを消す
autocmd BufWritePre * :%s/\s\+$//e

" source ~/.vimrcをさくっと出来る様に
command! Svim :source ~/.vimrc

" tag jump with new tab
nnoremap <C-\> :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>

" 以下、NeoBundle適用
" 参考: https://github.com/Shougo/neobundle.vim
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

" Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" ctrlp(ファイル検索)
NeoBundle 'kien/ctrlp.vim'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" ctrlp設定追加。参考http://qiita.com/ArcCosine@github/items/5ece3f39481f6aab9bc5
let g:ctrlp_mruf_max            = 500 " MRUの最大記録数
let g:ctrlp_open_new_file       = 1   " 新規ファイル作成時にタブで開く
" ctrlp設定追加。参考http://atmarksharp.com/posts/ctrlp-vim-plugin.html
" nnoremap <C-p> :CtrlPMixed<Return>
let g:ctrlp_map = '<Nop>' "<C-p>は切る. 参考: http://qiita.com/oahiroaki/items/d71337fb9d28303a54a8
nnoremap ,f :CtrlPMRUFiles<Return>
nnoremap ,b :CtrlPBuffer<Return>
nnoremap ,x :CtrlP<Return>
" ctrlp設定追加。http://qiita.com/oahiroaki/items/d71337fb9d28303a54a8
let g:ctrlp_extensions = ['quickfix', 'dir', 'line']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'
nnoremap ,d :<C-u>CtrlPDir<CR>
nnoremap ,l :<C-u>CtrlPLine<CR>
" ctrlp設定追加。rootを.gitとか.svnがあるディレクトリにする。http://kien.github.io/ctrlp.vim/
let g:ctrlp_working_path_mode = 'r'
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" agをctrlpでの検索に使用
" 参考: http://christina04.hatenablog.com/entry/2014/10/30/100612
if executable('ag')
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif

" vimproc(vimshellに必要)
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" vimshell
NeoBundle 'Shougo/vimshell'

" Neocomplcache
NeoBundle 'Shougo/neocomplcache'

" vim-endwise
NeoBundle 'tpope/vim-endwise'

" taglist
" http://d.hatena.ne.jp/mrgoofy33/20091103/1257199860
NeoBundle 'vim-scripts/taglist.vim'
" taglistの設定
" http://blog.kawa-xxx.jp/entry/20120805/1344134131
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags --append=no'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1

" 引用符を付ける
NeoBundle 'surround.vim'

" HTMLを書く
NeoBundle 'mattn/emmet-vim'

" js
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'prettier/vim-prettier'

" template in js and coffee
NeoBundle 'Quramy/vim-js-pretty-template'

" json
NeoBundle 'leshill/vim-json'

" scala
NeoBundle 'derekwyatt/vim-scala'

" haml
NeoBundle 'tpope/vim-haml'

" c++
NeoBundle 'octol/vim-cpp-enhanced-highlight'

" rust
NeoBundle 'rust-lang/rust.vim'

" haskell
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'dag/vim2hs'

" elixir
NeoBundle 'elixir-lang/vim-elixir'

" nginx
NeoBundle 'chr4/nginx.vim'

" vim-rubyを導入
NeoBundle 'vim-ruby/vim-ruby'

" agコマンドをvimから使えるようにする
" 参考: http://blog.glidenote.com/blog/2013/02/28/the-silver-searcher-better-than-ack/
NeoBundle 'rking/ag.vim'

" window分割&移動キーバインド
" 参考: http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
NeoBundle 'kana/vim-submode'

" switch.vimを導入
" 参考: http://qiita.com/alpaca_taichou/items/ab2ad83ddbaf2f6ce7fb
NeoBundle 'AndrewRadev/switch.vim'

" switch.vimを導入
" 参考: https://github.com/thoughtbot/vim-rspec
" NeoBundle 'thoughtbot/vim-rspec'

" vim-rspec.vimを導入
" 参考: http://kazuph.hateblo.jp/entry/2012/11/28/233413
NeoBundle 'skwp/vim-rspec'

" API Blueprint
NeoBundle 'kylef/apiblueprint.vim'

" TypeScript環境
NeoBundle 'leafgarland/typescript-vim'

" パス名をコピー
NeoBundle 'vim-scripts/copypath.vim'

" QuickFixをハイライト
NeoBundle 'jceb/vim-hier'

" Git コマンドを使う
" 参考: http://yuku-tech.hatenablog.com/entry/20110427/1303868482
NeoBundle 'tpope/vim-fugitive'

" Swift
NeoBundle 'toyamarinyon/vim-swift'

" llvm
NeoBundle 'rhysd/vim-llvm'

" go
NeoBundle 'fatih/vim-go'

" NeoBundle設定終了
" 参考: https://github.com/Shougo/neobundle.vim
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

autocmd BufNewFile,BufRead *.twig set syntax=htmldjango

" js prettier
let g:prettier#autoformat = 0
let g:prettier#exec_cmd_path = "/usr/local/bin/prettier"
" let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx Prettier
" prettier rules
let g:prettier#config#print_width = 120
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#semi = 'true'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#trailing_comma = 'es5'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#parser = 'babylon'

"バッファ全体にxmpfilterを実行
nmap <silent> <C-x><C-p> mzggVG!xmpfilter -a<cr>'z
imap <silent> <C-x><C-p> <ESC><C-x><C-p>

"現在業/選択行に「# =>」マークを追加
vmap <silent> <C-x><C-m> :!xmpfilter -m<CR>
nmap <silent> <C-x><C-m> V<C-x><C-m>
imap <silent> <C-x><C-m> <ESC><C-x><C-m>a

" dash用設定
function! s:dash(...)
  let ft = &filetype
  if &filetype == 'python'
    let ft = ft.'2'
  endif
  let ft = ft.':'
  let word = len(a:000) == 0 ? input('Dash search: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
  call system(printf("open dash://'%s'", word))
endfunction
command! -nargs=* Dash call <SID>dash(<f-args>)
" dashでrailsのdocumentを引く
au User Rails nnoremap <buffer><C-K><C-K> :Dash rails:<C-R><C-W><CR>

" window分割&移動キーバインド
" 参考: http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
nnoremap s <Nop>
nnoremap so :vsplit<Return>
nnoremap su :sp<Return>
nnoremap sh <C-W>h
nnoremap sl <C-W>l
nnoremap sj <C-W>j
nnoremap sk <C-W>k
nnoremap sH <C-w>H
nnoremap sL <C-w>L
nnoremap sJ <C-w>J
nnoremap sK <C-w>K

" sindowサイズ変更
nnoremap s= <C-w>=
call submode#enter_with('bufmove', 'n', '', 's.', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's,', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '.', '<C-w>>')
call submode#map('bufmove', 'n', '', ',', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" tab間の移動を簡単に
nnoremap <C-n> :tabprevious<Return>
nnoremap <C-p> :tabnext<Return>

" jqをvim内から使う
" 参考: http://qiita.com/tekkoc/items/324d736f68b0f27680b8
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq 95fe1a73-e2e2-4737-bea1-a44257c50fc8quot;" . l:arg . "95fe1a73-e2e2-4737-bea1-a44257c50fc8quot;"
endfunction

" kobitoをvimから使う
" 参考: http://qiita.com/Linda_pp/items/ec458977a6552050855b
function! s:open_kobito(...)
    if a:0 == 0
        call system('open -a Kobito '.expand('%:p'))
    else
        call system('open -a Kobito '.join(a:000, ' '))
    endif
endfunction

" 引数のファイル(複数指定可)を Kobitoで開く
" （引数無しのときはカレントバッファを開く
command! -nargs=* Kobito call s:open_kobito(<f-args>)
" Kobito を閉じる
command! -nargs=0 KobitoClose call system("osascript -e 'tell application \"Kobito\" to quit'")
" Kobito にフォーカスを移す
command! -nargs=0 KobitoFocus call system("osascript -e 'tell application \"Kobito\" to activate'")

" vimgrepの検索結果を移動
" http://qiita.com/yuku_t/items/0c1aff03949cb1b8fe6b
" nnoremap Q :cprevious<CR>   " 前へ
" nnoremap q :cnext<CR>       " 次へ
autocmd QuickFixCmdPost *grep* cwindow

" git管理下のファイルに対してvimgrep
" このスライドがすごく参考になった
" http://www.slideshare.net/cohama/vim-script-vimrc-nagoyavim-1
command! -nargs=* GitGrep call s:GitGrep(<f-args>)
function! s:GitGrep(...)
  execute "vimgrep " . a:1 . " `git ls-files`"
endfunction

" vimrcを即座に編集
" http://www.slideshare.net/cohama/vim-script-vimrc-nagoyavim-1
nnoremap <F5> :<C-u>tabedit $MYVIMRC<CR>
nnoremap <F6> :<C-u>source $MYVIMRC<CR>

" Go用の設定。
" http://qiita.com/methane/items/4905f40e4772afec3e60
" Go に付属の plugin と gocode を有効にする
set rtp^=${GOROOT}/misc/vim
set rtp^=${GOPATH}/src/github.com/nsf/gocode/vim
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4
au BufWritePre *.go GoFmt

" Neocomplcache用設定
" https://github.com/Shougo/neocomplcache.vim
" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType go setlocal omnifunc=gocomplete#Complete

" switch.vim
" 参考の設定: https://gist.github.com/alpaca-tc/6696152
" ------------------------------------
" switch.vim
" ------------------------------------
function! s:separate_defenition_to_each_filetypes(ft_dictionary) "{{{
  let result = {}

  for [filetypes, value] in items(a:ft_dictionary)
    for ft in split(filetypes, ",")
      if !has_key(result, ft)
        let result[ft] = []
      endif

      call extend(result[ft], copy(value))
    endfor
  endfor

  return result
endfunction"}}}

nnoremap ! :Switch<CR>
let s:switch_definition = {
      \ '*': [
      \   ['is', 'are']
      \ ],
      \ 'ruby,eruby,haml' : [
      \   ['if', 'unless'],
      \   ['while', 'until'],
      \   ['.blank?', '.present?'],
      \   ['include', 'extend'],
      \   ['class', 'module'],
      \   ['.inject', '.delete_if'],
      \   ['.map', '.map!'],
      \   ['attr_accessor', 'attr_reader', 'attr_writer'],
      \ ],
      \ 'Gemfile,Berksfile' : [
      \   ['=', '<', '<=', '>', '>=', '~>'],
      \ ],
      \ 'ruby.application_template' : [
      \   ['yes?', 'no?'],
      \   ['lib', 'initializer', 'file', 'vendor', 'rakefile'],
      \   ['controller', 'model', 'view', 'migration', 'scaffold'],
      \ ],
      \ 'erb,html,php' : [
      \   { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' },
      \ ],
      \ 'rails' : [
      \   [100, ':continue', ':information'],
      \   [101, ':switching_protocols'],
      \   [102, ':processing'],
      \   [200, ':ok', ':success'],
      \   [201, ':created'],
      \   [202, ':accepted'],
      \   [203, ':non_authoritative_information'],
      \   [204, ':no_content'],
      \   [205, ':reset_content'],
      \   [206, ':partial_content'],
      \   [207, ':multi_status'],
      \   [208, ':already_reported'],
      \   [226, ':im_used'],
      \   [300, ':multiple_choices'],
      \   [301, ':moved_permanently'],
      \   [302, ':found'],
      \   [303, ':see_other'],
      \   [304, ':not_modified'],
      \   [305, ':use_proxy'],
      \   [306, ':reserved'],
      \   [307, ':temporary_redirect'],
      \   [308, ':permanent_redirect'],
      \   [400, ':bad_request'],
      \   [401, ':unauthorized'],
      \   [402, ':payment_required'],
      \   [403, ':forbidden'],
      \   [404, ':not_found'],
      \   [405, ':method_not_allowed'],
      \   [406, ':not_acceptable'],
      \   [407, ':proxy_authentication_required'],
      \   [408, ':request_timeout'],
      \   [409, ':conflict'],
      \   [410, ':gone'],
      \   [411, ':length_required'],
      \   [412, ':precondition_failed'],
      \   [413, ':request_entity_too_large'],
      \   [414, ':request_uri_too_long'],
      \   [415, ':unsupported_media_type'],
      \   [416, ':requested_range_not_satisfiable'],
      \   [417, ':expectation_failed'],
      \   [422, ':unprocessable_entity'],
      \   [423, ':precondition_required'],
      \   [424, ':too_many_requests'],
      \   [426, ':request_header_fields_too_large'],
      \   [500, ':internal_server_error'],
      \   [501, ':not_implemented'],
      \   [502, ':bad_gateway'],
      \   [503, ':service_unavailable'],
      \   [504, ':gateway_timeout'],
      \   [505, ':http_version_not_supported'],
      \   [506, ':variant_also_negotiates'],
      \   [507, ':insufficient_storage'],
      \   [508, ':loop_detected'],
      \   [510, ':not_extended'],
      \   [511, ':network_authentication_required'],
      \ ],
      \ 'rspec': [
      \   ['describe', 'context', 'specific', 'example'],
      \   ['before', 'after'],
      \   ['be_true', 'be_false'],
      \   ['get', 'post', 'put', 'delete'],
      \   ['==', 'eql', 'equal'],
      \   { '\.should_not': '\.should' },
      \   ['\.to_not', '\.to'],
      \   { '\([^. ]\+\)\.should\(_not\|\)': 'expect(\1)\.to\2' },
      \   { 'expect(\([^. ]\+\))\.to\(_not\|\)': '\1.should\2' },
      \ ],
      \ 'markdown' : [
      \   ['[ ]', '[x]']
      \ ]
      \ }

let s:switch_definition = s:separate_defenition_to_each_filetypes(s:switch_definition)
function! s:define_switch_mappings() "{{{
  if exists('b:switch_custom_definitions')
    unlet b:switch_custom_definitions
  endif

  let dictionary = []
  for filetype in split(&ft, '\.')
    if has_key(s:switch_definition, filetype)
      let dictionary = extend(dictionary, s:switch_definition[filetype])
    endif
  endfor

  if exists('b:rails_root')
    let dictionary = extend(dictionary, s:switch_definition['rails'])
  endif

  if has_key(s:switch_definition, '*')
    let dictionary = extend(dictionary, s:switch_definition['*'])
  endif
endfunction"}}}

augroup SwitchSetting
  autocmd!
  autocmd Filetype * if !empty(split(&ft, '\.')) | call <SID>define_switch_mappings() | endif
augroup END

" tabを開いてからAg
command! -nargs=* At call s:At(<f-args>)
function! s:At(...)
  execute ":tabedit"
  execute ":Ag " . a:1
endfunction

" Agでの検索を簡単にする
nnoremap siw yiw :At <C-r>0<CR> /<C-r>0<CR>
nnoremap siW yiW :At <C-r>0<CR> /<C-r>0<CR>

" Agでの検索結果のハイライトはさりげなく消す
nnoremap <Esc><Esc><Esc> :HierStop<CR>

" quickrun関連の設定
" 参考: http://d.hatena.ne.jp/osyo-manga/20130311/1363012363
let g:quickrun_config = {
\   '_' : {
\       'runner' : 'vimproc',
\       "runner/vimproc/updatetime" : 60,
\       "outputter/buffer/split" : ":botright 12sp",
\       "outputter/buffer/close_on_empty" : 1,
\   },
\}
nnoremap <C-c> call quickrun#is_running() ? call quickrun#sweep_sessions()

" vim から rspec を Quickrunで実行
" 参考: http://d.hatena.ne.jp/joker1007/20111208/1323324569
let g:quickrun_config['rspec/bundle'] = {
  \ 'type': 'rspec/bundle',
  \ 'command': 'rspec',
  \ 'exec': 'bundle exec %c %s'
  \}
let g:quickrun_config['rspec/normal'] = {
  \ 'type': 'rspec/normal',
  \ 'command': 'rspec',
  \ 'exec': '%c %s'
  \}
function! RSpecQuickrun()
  let b:quickrun_config = {'type' : 'rspec/bundle'}
endfunction
autocmd BufReadPost *_spec.rb call RSpecQuickrun()

nnoremap qq :QuickRun<CR>

" 80文字教
" http://blog.remora.cx/2013/06/source-in-80-columns-2.html
noremap <Plug>(ToggleColorColumn)
            \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
            \   join(range(81, 9999), ',')<CR>
" ノーマルモードの 'cc' に割り当てる
nmap cc <Plug>(ToggleColorColumn)

" cpp
au BufRead,BufNewFile *.cpp set filetype=cpp

" jsx
au BufRead,BufNewFile *.jsx set filetype=javascript

" gradle
" cf. https://github.com/vim/vim/issues/7280#issuecomment-725510148
au BufRead,BufNewFile *.gradle set re=0

" llvm
" https://github.com/Superbil/llvm.vim
au BufRead,BufNewFile *.ll set filetype=llvm
