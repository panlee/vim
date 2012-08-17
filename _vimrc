"=========================================================================
" DesCRiption: custom vimrc file，for Linux/Windows, GUI/Console
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimr"
" Last Change: 2011/07/20 09:59"
" Version:     1.0
"
"=========================================================================
"not compatible with vi
set nocompatible

filetype  plugin on
filetype  indent on

" return OS type, eg: windows, or linux, mac, et.st..
function! MySys()
    if has("win16") || has("win32") || has("win64") || has("win95")
        return "windows"
    elseif has("unix")
        return "linux"
    endif
endfunction

" set user catalogue $VIMFILES
if MySys() == "windows"
    let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
    let $VIMFILES = $HOME.'/.vim'
	set runtimepath+=/usr/share/vim/vim73/colors
endif
"source $VIMRUNTIME/mswin.vim
"behave mswin

"set doc files catalogue
let helptags=$VIMFILES.'/doc'

"not use the setting bellow when open with evim mode
if v:progname =~? "evim"
  finish
endif

set diffexpr=MyDiff()
set nobackup		" not backup
set history=100		" save 100 history record
set showcmd		" show the command that not finished

"not use Ex mode, accelerator key Q
map Q gq

"support mouse when use terminal mode
if has('mouse')
  set mouse=a
  set mousehide                                   " Hide the mouse when typing text
endif

" in insert mode,user CTRL-U to delete a section of text,use CTRL-G u to
" recover from the palace that first changed and CTRL-U to recover one line
inoremap <C-U> <C-G>u<C-U>
set autochdir               " auto change the current catalogue as the current file's catalogue
set wildmenu				" autocomple in boost mode
set report=0				" use: commands command，to tell which line was changed
set noerrorbells            " shutdown the bell when error accurs
set novisualbell            " shutdown visual bell
set t_vb=                   " the terminal code of emptying error bell
set showmatch               " delay some time then jump to the matched bracket when insert bracket
"set matchtime=2           " the delay time to jump to the matched bracket
set magic                   " set magic
set hidden                  " allow to change buffer while not save the file,vim in charge of the unsaved file

"searching setting
set ignorecase smartcase    " ignore case when searching,but sensitive when have one or more than upper alpha
set nowrapscan              " fobid start over when reach the head or tail
set incsearch               " show the search result when searching

"interface setting
if &t_Co > 2 || has("gui_running")	"hignlight the syntax when terminal allows color
  syntax on
  set hlsearch
endif
"colorscheme desertEx        " color scheme setting
colorscheme molokai
set number                  " show line number
set cursorline              " highlight the current line
set confirm					" popup confirm message when save unsaved or read-only files
set shortmess=atI			" do't show the startup message of help the children
set guioptions-=T           " hide tool bar
"set guioptions-=m          " hide menu bar
set laststatus=2            " show state bar(default value is 1, otherwise not show)
set ruler                   " open state ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%) "ruler format
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\
                            " set the message that show on state bar

set foldenable              " enable fold
set foldmethod=syntax       " set syntax fold
set foldcolumn=0            " set the width of fold field
setlocal foldlevel=1        " set fold lever
" set foldclose=all         " set auto colse fold
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
                            " toggle fold with space key
set fillchars=vert:\ ,stl:\ ,stlnc:\ " show blanks in spilted window ,easy to read

"text format
set formatoptions=tcrqn	    " auto format
set autoindent				" inherit indent method,adapt to multi-line comment
set smartindent             " smart indent when start a new line
set cindent					" indent metnod like C language
set shiftwidth=4            " set the width between << and >> as 4
set softtabstop=4           " delete 4 space when backspace
set tabstop=4               " set tap width 4
set noexpandtab				" not substitude tab with space
set nowrap					" no wrap
set smarttab				" use tab at the begining of line and section
set backspace=indent,eol,start " not set delete 'carrage return' with backspace or delete key in insertion mode
set cmdheight=1             " set command line height 1
set hlsearch                " highlight the text that found in searching
set iskeyword+=_,$,@,%,#,-  " do't split the line with the following characters
set viminfo+=!				" save global variable

"inital window size and position
winpos 50 50
set lines=30
set columns=100
au GUIENTER * simalt ~x		"max window

" set font and chinese support
if has("win32")
	set guifont=Consolas:h12:cANSI
"	set guifont=Courier_New:h12:cANSI
endif

" config multi-language environment
" let &termencoding=&encoding
if has("multi_byte")
    " UTF-8 code
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fencs=utf-8,gbk

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    if has("win32")
		set langmenu=none "set language as englist by force
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        "language messages zh_CN.utf-8
        language messages en_US.utf-8
    endif
else
    echoerr " sorry, this (g)vim do not specialize multi-byte text while compiling
endif

"maximize window when startup
"if has('win32')
"    au GUIEnter * simalt ~x
"else
"    au GUIEnter * call MaximizeWindow()
"endif
" 
"function! MaximizeWindow()
"    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
"endfunction

" Tab shortcut key
nnoremap <C-TAB> :tabnext<CR>
nnoremap <C-S-TAB> :tabprev<CR>

" accelerator key about tab
 map tn :tabnext<cr>
 map tp :tabprevious<cr>
 map td :tabnew <cr>
 map te :tabedit
 map tc :tabclose<cr>

 "map alt+direckey
 nnoremap <A-Up> <C-W>k 
 nnoremap <A-Down> <C-W>j 
 nnoremap <A-Left> <C-W>h 
 nnoremap <A-Right> <C-W>l

 inoremap <A-Up> <Esc><C-W>ki
 inoremap <A-Down> <Esc><C-W>ji 
 inoremap <A-Left> <Esc><C-W>hi 
 inoremap <A-Right> <Esc><C-W>li

"when the window is spilted, you need press c-w twice to change the working window
"now redirect key c-k to change working window easily

"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

function <SID>menu_mm()
	if !exists('s:menu_maxmin')
		exe ':emenu  &Window.M&in\ Height'
		let s:menu_maxmin=1
	else
		exe ':emenu &Window.&Max\ Height'
		unlet s:menu_maxmin
	endif
endfunction

"nnoremap <silent> <F2> :call <SID>menu_mm()<CR>
"nnoremap <silent> <F10> :wqa<CR>

"-------------------------------------------------------------------------------
"  some additional hot keys
"-------------------------------------------------------------------------------
"    F2   -  write file without confirmation
"    F3   -  call file explorer Ex
"    F4   -  show tag under curser in the preview window (tagfile must exist!)
"    F5   -  open quickfix error window
"    F6   -  close quickfix error window
"    F7   -  display previous error
"    F8   -  display next error   
"-------------------------------------------------------------------------------
"
map <silent> <F1> :NERDTree<CR> 
map <silent> <F2> :NERDTreeClose<CR> 
"map   <silent> <F2>        :write<CR>
"map   <silent> <F3>        :Explore<CR>
nnoremap <silent> <F3> :Grep<CR>
"nmap  <silent> <F4>        :exe ":ptag ".expand("<cword>")<CR>
map   <silent> <F5>        :copen<CR>
map   <silent> <F6>        :cclose<CR>
map   <silent> <F7>        :cp<CR>
map   <silent> <F8>        :cn<CR>

imap <silent> <F1> :NERDTree<CR> 
imap <silent> <F2> :NERDTreeClose<CR> 
"imap  <silent> <F2>   <Esc>:write<CR>
"imap  <silent> <F3>   <Esc>:Explore<CR>
"imap  <silent> <F4>   <Esc>:exe ":ptag ".expand("<cword>")<CR>
imap  <silent> <F5>   <Esc>:copen<CR>
imap  <silent> <F6>   <Esc>:cclose<CR>
imap  <silent> <F7>   <Esc>:cp<CR>
imap  <silent> <F8>   <Esc>:cn<CR>

"-------------------------------------------------------------------------------
" comma always followed by a space
"-------------------------------------------------------------------------------
inoremap  ,  ,<Space>

"-------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap { {}<Left>
""
"vnoremap ( s()<Esc>P<Right>%
"vnoremap [ s[]<Esc>P<Right>%
"vnoremap { s{}<Esc>P<Right>%
""
""-------------------------------------------------------------------------------
"" autocomplete quotes (visual and select mode)
""-------------------------------------------------------------------------------
"xnoremap  '  s''<Esc>P<Right>
"xnoremap  "  s""<Esc>P<Right>
"xnoremap  `  s``<Esc>P<Right>

"some not bad map tranfer syntax(use when file has two mixed language)
"nnoremap <leader>1 :set filetype=xhtml<CR>
"nnoremap <leader>2 :set filetype=css<CR>
"nnoremap <leader>3 :set filetype=javascript<CR>
"nnoremap <leader>4 :set filetype=php<CR>
" set fileformats=unix,dos,mac
" nmap <leader>fd :se fileformat=dos<CR>
" nmap <leader>fu :se fileformat=unix<CR>

" use Ctrl+[l|n|p|cc] to list|next|previous|jump to count the result
" map <C-x>l <ESC>:cl<CR>
" map <C-x>n <ESC>:cn<CR>
" map <C-x>p <ESC>:cp<CR>
" map <C-x>c <ESC>:cc<CR>

" plugin configure
" open when 'autocommand' is supported
if has("autocmd")
  " open auto search file
  " use default configure file, so that mail gets 'tw' set to 72,
  " open 'cindent' when the file is C file
  " auto load file:plugin
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent		" open suto search
endif " has("autocmd"）

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" make Tohtml generate html whith CSS syntax
" syntax/2html.vim，:runtime! syntax/2html.vim
let html_use_css=1

" Python file commom configure，eg: no tab
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
"autocmd FileType python map <F12> :!python %<CR>

" Ctrl-c ,copy when text is selected
vmap <C-c> "+y

" open javascript fold
"let b:javascript_fold=1
" support dom.html and css when open javascript files
"let javascript_enable_domhtmlcss=1
" set the path of ~/.vim/dict/
"autocmd filetype javascript set dictionary=$VIMFILES/dict/javascript.dict
"autocmd filetype css set dictionary=$VIMFILES/dict/css.dict
"autocmd filetype php set dictionary=$VIMFILES/dict/php.dict


"-----------------------------------------------------------------
" plugin - CTags.vim jump in files
" \-R	generate tags
" :set tags=    set tags catalogue
" C-] jump to the place than tags point to
" <C-T> jump bace
"-----------------------------------------------------------------
let Tlist_Sort_Type = "name"
			"sort by name
let Tlist_Use_Right_Window = 0	"show window at right
let Tlist_Compart_Format = 1
			" compress format
let Tlist_Exist_OnlyWindow = 1
			" when has only one buffer，kill window and buffer
let Tlist_File_Fold_Auto_Close = 0
			" tagsdo't close the tags that belongs to other files
let Tlist_Enable_Fold_Column = 0
			" not show fold tree
"nmap <F10> <Esc>:!ctags -R *<CR>
"inoremap <F10> <Esc>:!ctags -R *<CR>
nmap <F10> <Esc>:!ctags --c++-kinds=+p --fields=+iaS --extra=+q -R *<CR>
inoremap <F10> <Esc>:!ctags --c++-kinds=+p --fields=+iaS --extra=+q -R *<CR>
noremap <silent> <F11>  <Esc><Esc>:Tlist<CR>
inoremap <silent> <F11>  <Esc><Esc>:Tlist<CR>
"<F9> <Esc> reset tags

"-----------------------------------------------------------------
" show .NFO files perfectly
"-----------------------------------------------------------------
set encoding=utf-8
function! SetFileEncodings(encodings)
let b:myfileencodingsbak=&fileencodings
let &fileencodings=a:encodings
endfunction
function! RestoreFileEncodings()
let &fileencodings=b:myfileencodingsbak
unlet b:myfileencodingsbak
endfunction
au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single au BufReadPost *.nfo call RestoreFileEncodings()

"-----------------------------------------------------------------
" plugin - taglist.vim  " view function list, ctags  programme is needed
" F4 show hidden taglist window
"-----------------------------------------------------------------
if MySys() == "windows"                " set the ctags programme path in windows system
    let Tlist_Ctags_Cmd = '"'.$VIMFILES.'/ctags.exe"'
elseif MySys() == "linux"              "set the ctags programme path in linux system
    let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
endif
let Tlist_Show_One_File = 1            " not show the tag of more than one files,just show the current one
let Tlist_Exit_OnlyWindow = 1          " if the taglist window is the last window,then exit vim
let Tlist_File_Fold_Auto_Close=1       " auto fold the function list that is not editing
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Process_File_Always = 1
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1
"let Tlist_Auto_Open=1	" open taglist when start vim

"-----------------------------------------------------------------
" plugin - winManager.vim  file explorer and window  manager
" wm show or hide winManager window
"-----------------------------------------------------------------
"let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
"let g:winManagerWindowLayout = "FileExplorer|TagList"	"set interface split
"let g:winManagerWidth = 30					"set the width of winmanager (default 25)
"nnoremap <silent> <F1> :WMToggle<cr>		"show or hide winmanager with F1
"let g:AutoOpenWinManager = 1

"-----------------------------------------------------------------
" plugin - Cscope.vim  you can use it as super tags
" cs find c|d|e|f|g|i|s|t name
" 0 or s	search C symbol (can jump comments)
" 1 or g	search definition
" 2 or d	search function called by it
" 3 or c	search function which call it
" 4 or t	serach current string
" 6 or e	search this egrep mode
" 7 or f	search this file
" 8 or i	search files which include this file
" reset 	reset all links
"-----------------------------------------------------------------
nmap <silent> <F4> <ESC>:call CreateDB() <CR>

function! CreateDB()
	!cscope -Rb
	cs reset
	cs add cscope.out
endfunction

if has("cscope")
	set csprg=$VIMFILES\cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"-----------------------------------------------------------------
" plugin - MiniBufExplorer.vim  " view and operate Buffer  quickly
" <Tab>		switch to the previous buffer
" <S-Tab>	switch to the next buffer
" <Enter>   open the buffer that the cursor is on
" d			delete the buffer that the cursor is on
"-----------------------------------------------------------------
"let g:miniBufExplMapCTabSwitchBufs = 1
				"<C-Tab>	loop forward to each buffer, and open it in front window
				"<C-S-Tab>	loop backward to each buffer, and open it in front window

"let g:miniBufExplMapWindowNavVim = 1
				"use <C-h,j,k,l> to switch to up,dowm,left,right windo
"let g:miniBufExplMapWindowNavArrows = 1
				"use <C-h,j,k,l> to switch to up,dowm,left,right windo

"-----------------------------------------------------------------
" plugin - mark.vim color different tags with different colors, easy to view  and debug plugin
" \m  mark or unmark the word under (or before) the cursor
" \r  manually input a regular expression.used in searching
" \n  clear this mark (i.e. the mark under the cursor), or clear all highlighted marks .
" \*  next MarkWord     \#  last MarkWord
" \/  next MarkWork of all MarkWords    \?  last MarkWork of all MarkWords
"-----------------------------------------------------------------

"-----------------------------------------------------------------
" plugin - NERD_tree.vim	 view file and catalogue in tree
" :ERDtree open NERD_tree         :NERDtreeClose    close NERD_tree
" o open or close file or catalogue						    t open in tag page
" T open the tags in background								! run this file
" p jump to upper catalogue									P jump to root
" K jump to the previous node								J jump to the last node
" u open upper catalogue					                m show system menu（add、delete、move）
" r freshen the current  catalogue in recursion     R freshen the root  catalogue in recursion
"-----------------------------------------------------------------

"-----------------------------------------------------------------
" plugin - NERD_commenter.vim   add comments on codes，
" [count],cc add comments of next 'count'  lines(7,cc)
" [count],cu cancel comments of next 'count'  lines(7,cn)
" [count],cm comment on the next 'count' lines with block comments(7,cm)
" ,cA insert /* */ at the end of a line, and into insertion mode, easy for comments。
" note：count is not necessary，default is current line
"-----------------------------------------------------------------
let NERDSpaceDelims=1       " insert a space between comment and statement
let NERDCompactSexyComs=1   " make multi-line comments beautiful

"-----------------------------------------------------------------
" plugin - DoxygenToolkit.vim  " generate document according to comments,and generate standard function comments quickly
"-----------------------------------------------------------------
let g:DoxygenToolkit_authorName="Asins - asinsimple AT gmail DOT com"
let g:DoxygenToolkit_briefTag_funcName="yes"
map <leader>da :DoxAuthor<CR>
map <leader>df :Dox<CR>
map <leader>db :DoxBlock<CR>
map <leader>dc a /*  */<LEFT><LEFT><LEFT>
let g:DoxygenToolkit_authorName="PanLee"
let g:DoxygenToolkit_licenseTag="My own license\<enter>"
let g:DoxygenToolkit_undocTag="DOXIGEN_SKIP_BLOCK"
let g:DoxygenToolkit_briefTag_pre = "@brief\t"
let g:DoxygenToolkit_paramTag_pre = "@param\t"
let g:DoxygenToolkit_returnTag = "@return\t"
let g:DoxygenToolkit_briefTag_funcName = "no"
let g:DoxygenToolkit_maxFunctionProtoLines = 30

"-----------------------------------------------------------------
" plugin – checksyntax.vim    JavaScript commom syntax
" accelerator key is F5
"-----------------------------------------------------------------
"let g:checksyntax_auto = 0 " not check syntax automatic

"-----------------------------------------------------------------
" plugin - NeoComplCache.vim   autocomple plugin
"-----------------------------------------------------------------
"let g:AutoComplPop_NotEnableAtStartup = 1
""let g:NeoComplCache_EnableAtStartup = 1
"let g:NeoComplCache_SmartCase = 1
" let g:NeoComplCache_TagsAutoUpdate = 1
" let g:NeoComplCache_EnableInfo = 1
" let g:NeoComplCache_EnableCamelCaseCompletion = 1
" let g:NeoComplCache_MinSyntaxLength = 3
" let g:NeoComplCache_EnableSkipCompletion = 1
" let g:NeoComplCache_SkipInputTime = '0.5'
" let g:NeoComplCache_SnippetsDir = $VIMFILES.'/snippets'
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" imap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
" smap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)

"-----------------------------------------------------------------
" plugin – a.vim	switch between c/h
" :A	switch c/h files in new buffer
" :AS	horizontally split window and open c/h file
" :AV	vertical split window and open c/h file
" :AT	create a tag page and open c/h file
"-----------------------------------------------------------------
nnoremap <silent> <F12> :A<CR>

"-----------------------------------------------------------------
" plugin -  Grep.vim   search in project
" :Grep   [<grep_options>] [<search_pattern> [<file_name(s)>]]
" :Grep	search in specialized files according  to specialized rules
" :Rgrep	ditto, but in recursive
" :GrepBuffer	search in all opened buffer
" :Bgrep	ditto
" :GrepArgs	search in argument filenames (:args)
" :Fgrep	run fgrep
" :Rfgrep	run fgrep in recursive
" :Egrep	run egrep
" :Regrep	run egrep in recursive
" :Agrep	run agrep
" :Ragrep	agrep in recursive
"-----------------------------------------------------------------

"-----------------------------------------------------------------
" plugin - new-omni-completion.vim   " autocomple
" Ctrl+P	switch to previous
" Ctrl+N	switch to next
" Ctrl+E	exit pull-dowm menu, and back to the text that input just now
" Ctrl+Y	exit pull-dowm menu,and accept current option
" Ctrl+X Ctrl+O popup a pull-dowm menu, show all matched tags
" Ctrl+X Ctrl+L		" autocomple the whole line
" Ctrl+X Ctrl+N		" autocomple key word according to current file
" Ctrl+X Ctrl+K		" autocomple key word according to dic
" Ctrl+X Ctrl+T		" autocomple key word according to synonym dic
" Ctrl+X Ctrl+I		" autocomple key word according to header file
" Ctrl+X Ctrl+]		" autocomple according to tags
" Ctrl+X Ctrl+F		" autocomple the filename
" Ctrl+X Ctrl+D		" autocomple the macro
" Ctrl+X Ctrl+V		" autocomple the vim command
" Ctrl+X Ctrl+U		" autocomple according to custom definition
" Ctrl+X Ctrl+S		" spell suggestion
"-----------------------------------------------------------------
" set completeopt=longest,menu	"close previw window  in autocomple mode

" ctags 索引文件 (根据已经生成的索引文件添加即可, 这里我额外添加了 hge 和 curl 的索引文件)
"set tags+=D:/ctags/tags/cpp
"set tags+=D:/ctags/tags/hge
"set tags+=D:/ctags/tags/curl

" OmniCppComplete setting
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 "show function prototype 
let OmniCpp_MayCompleteDot = 1   " input ., auto complete
let OmniCpp_MayCompleteArrow = 1 " input ->, auto complete
let OmniCpp_MayCompleteScope = 1 " input :: auto complete
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"auto close complete window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest
"color setting
highlight Pmenu    guibg=darkgrey  guifg=black
highlight PmenuSel guibg=lightgrey guifg=black

"-----------------------------------------------------------------
" plugin - matchit.vim   expand % " command to enable jump in nest tags and statements
" % forward direction match     g% backward direction match
" [% fix block head     ]% fix block tail
"-----------------------------------------------------------------

"-----------------------------------------------------------------
" plugin - vcscommand.vim   expand % " command to enable jump in nest tags and statements
" SVN/git managemant tool
"-----------------------------------------------------------------

"-----------------------------------------------------------------
" plugin – ZenCoding.vim  "very cool plugin, generate html
" code
" up-to-date edition：http://github.com/mattn/zencoding-vim
" commonly used command：http://nootn.com/blog/Tool/23/
"-----------------------------------------------------------------

"-----------------------------------------------------------------
"plugin - c-support.vim
"-----------------------------------------------------------------
let g:C_Dictionary_File = $VIMFILES.'/c-support/wordlists/c-c++-keywords.list,'.
			\                   $VIMFILES.'/c-support/wordlists/k+r.list,'.
			\                   $VIMFILES.'/c-support/wordlists/stl_index.list,'.
			\                   $VIMFILES.'/c-support/wordlists/MyC.list'
"let g:C_LoadMenus = "no"

function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

