" .vimrc
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Erase pre-existing autocmds.
autocmd!

" None of those annoying bells
set noerrorbells

if has("gui")
  " set the gui options to:
  "   g: grey inactive menu items
  "   m: display menu bar
  "   r: display scrollbar on right side of window
  "   b: display scrollbar at bottom of window

  "   t: enable tearoff menus on Win32
  "   T: enable toolbar on Win32
  set go=gmr
  set guifont=Courier
endif

" set path for GO lang syntax
set runtimepath+=~/.gosyntax

" automatically prepend indent of previous line when I create new lines
set smartindent
set autoindent
set cindent
filetype plugin indent on

" Basic pair completion trick from
" http://vim.wikia.com/wiki/VimTip630
inoremap {	{}<Left>
inoremap {<CR>	{<CR>.<CR>}<Esc><Up>$<Del><insert><Right>
inoremap {{	{
inoremap {}	{}

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cst
    set csprg=cscope-fast
    set tagstack

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>o :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-@>o :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>o :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif

" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Better command-line completion
set wildmenu

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
" Always show the status line with ruler.
set laststatus=2

" Treat . [ * special in patterns
set magic

" Update xterminal titles.
set title
set titleold=""

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Display line numbers on the left
set number

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set is hlsearch

" syntax highlighting
syntax on

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=10

" Makes search act like search in modern browsers
set incsearch

" Keep 100 commands in the history
set history=100

" make the status line reverse and bold
set highlight=srb

" Emacs-like auto-indent for C (only indent when I hit tab in column 0)
"set cinkeys=0{,0},:,0#,!0<Tab>,!^F

" Keep return types <t> and parameters <p> in K&R-style C at the left edge <0>
" Indent continuation lines/lines with unclosed parens 4 spaces <+4,(4,u4,U1>
" Don't indent case labels within a switch <:0>
"set cinoptions=p0,t0,+4,(4,u4,U1,:0

" Default BufEnter action.
" NOTE:	this action must be declared first because later cmds will
"	override these default settings
"autocmd BufEnter * setlocal fo=tcql nocindent autoindent comments& listchars& list&

" Activate C indenting and comment formatting when editing C or C++
autocmd BufEnter *.cc,*.c,*.h setlocal tw=80 fo=croq cindent

" The list/listchars options cause the trailing spaces to be highlighted
" Don't constantly fsync() the swap file
" Also, save swap files locally in /var/tmp
" 
" Commenting the lines below - all swap files in one place - not good
"set swapsync=
"set directory=<path>

" Put 'mouse' selected text in systems' copy clipboard
set clipboard=unnamedplus	" use the clipboards of vim and win
"set paste			" Paste from a windows or from vim
set go+=a			" Visual selection copied the clipboard

" Key bindings - cscope/tags support
map  :cs find g <C-R>=expand("<cword>")

 " find definition
map ^S :cs find s <C-R>=expand("<cword>")

 " find C symbol
map  :cs find x <C-R>=expand("<cword>")

 " find callers
map  :cs find t <C-R>=expand("<cword>")

 " find assignments

" File suffixes to ignore for editing selection (via :e).
set suffixes=.o,.bc,.aux,.dvi,.gz,.idx,.log,.ps,.swp,.tar,.tgz,~

" insert comment leader for 'o' or 'O'
"set formatoptions+=o

" never start select mode
set selectmode+=mouse

" Text wrapping is a little earlier than 80 characters
autocmd BufEnter README,NOTES,*.html,*.lt?,*.tex,*.tx?,*.[0-9],*.man,*.eml,*.txt set textwidth=79
autocmd BufLeave README,NOTES,*.html,*.lt?,*.tex,*.tx?,*.[0-9],*.man,*.eml,*.txt set textwidth=80

" highlight when over column 80
au BufWinEnter *.c,*.py,*.sh,*.txt let w:m1=matchadd('Search', '\%<80v.\%>79v', -1)
au BufWinEnter *.c,*.py,*.sh,*.txt let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

"Always show current position
set ruler

" Automatically write (save) the file if changed before opening another
" file with :n or before giving a Unix command with :!.
set autowrite

" set paste toggle
set pastetoggle=<F10>

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

colorscheme default

" Set encoding for using extended ascii characters.
"set encoding=utf-8

" Use > to represent tabs and -| to reppresent line ends
"set list
"set listchars=tab:¤\ ,eol:Ø

" Adding plugins
"call plug#begin()

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go'

"call plug#end()

if system('uname -s') == "Linux\n"
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
