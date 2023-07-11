call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sainnhe/sonokai'
Plug 'onsails/lspkind-nvim'         " icons for LSP (requires Nerd-Font)
Plug 'nvim-tree/nvim-web-devicons'  " required by lspsaga and nvim-tree

Plug 'nvim-tree/nvim-tree.lua'

Plug 'godlygeek/tabular'            " used by vim-markdown
Plug 'folke/zen-mode.nvim'          " toggle windows into fullscreen

Plug 'williamboman/mason.nvim'      " Install external LSP servers
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'  " Ensure list of packages
Plug 'mfussenegger/nvim-jdtls'      " Dedicated LSP manager for Java w/ jdtls
                                    " See ./ftplugin/java.lua
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

Plug 'folke/which-key.nvim'

call plug#end()

" Disable netrw, recommended by nvim-tree
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" General {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable builtin completion as we use nvim-cmp
set complete=
set completeopt=
set confirm                     " Ask for confirmation in some situations (:q)
set exrc                        " Scan working dir for .vimrc
set hidden                      " allows to change buffer without saving
set history=50                  " How many lines of history to remember
set ignorecase smartcase        " case insensitive search, except when mixing cases
set modeline                    " we allow modelines in textfiles to set vim settings
set mouse=a                     " enable mouse in all modes
set nocompatible                " get out of horrible vi-compatible mode
set noerrorbells                " don't make noise
set novisualbell                " don't blink
set timeoutlen=200              " timeout for mapped key sequences to complete
set updatetime=1000             " idle time for CursorHold and writing swap
" }}}
" File and filetype settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8              " Let Vim use utf-8 internally
set fileencoding=utf-8          " Default for new files
set fileformat=unix             " default file format
set fileformats=unix,dos,mac    " support all three, in this order
set nowritebackup               " don't create backup file during writing
set termencoding=utf-8          " Terminal encoding

" Enable filetype detection by extension and content. This sets the filetype
" option (check with ':set ft?') and triggers the FileType event (see autocmd
" below). The below command enables:
"  - plugin:    load ft specific plugin (e.g. ~rtp/plugin/php.vim)
"  - indent:    load ft specific indent file (e.g. ~rtp/indent/php.vim)
filetype plugin indent on
" }}}
" Text Formatting/Tab settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting (based on detected filetype)
syntax on

set autoindent                  " keep indent on next line and make BS work with indenting
set colorcolumn=81              " show color bar at max (soft) line length
set conceallevel=2              " conceal e.g. **x** with bold x in markdown
set formatoptions=tcrqn         " autowrap and comments (see :h 'fo-table)
set hlsearch                    " highlight search phrase matches (reset with :noh)
set incsearch                   " do highlight as you type you search phrase
set list                        " show tabs, trailings spaces, ...
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
set matchtime=5                 " tenths of a second to blink matching brackets
set showmatch                   " show matching brackets
set smarttab                    " Make Tab work fine with spaces
set wrap                        " wrap lines that exceed screen

" Default indent settings
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" }}}
" Auto commands {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup java
  autocmd!
  autocmd FileType java setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent
  autocmd FileType java setlocal colorcolumn=120
augroup END

augroup help
  autocmd!
  " q to exit help
  autocmd FileType help noremap <buffer> q :q<CR>
  " "<CR>", "<BS>" to follow help link / go back
  autocmd FileType help noremap <buffer> <CR> <c-]>
  autocmd FileType help noremap <buffer> <BS> <c-t>
augroup END

augroup quickfix
  " q to exit Toc/Quickfix
  autocmd FileType qf noremap <buffer> q :q<CR>
  " unlist quickfix buffer to exclude it from :bn / :bp
  autocmd Filetype qf set nobuflisted
augroup END

" }}}
" UI/Colors {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark             " Adjust default color groups for dark scheme
set backspace=indent,eol,start  " make backspace work normal
set cmdheight=1                 " the command bar is 1 high
set cursorline                  " highlight the line the cursor is in
set fillchars=vert:\ ,stl:\ ,stlnc:\    " make the splitters between windows be blank
set laststatus=2                " always show the status line
set lazyredraw                  " do not redraw while running macros (much faster)
set number                      " turn on line numbers
set report=0                    " always report how many lines where changed
set ruler                       " Always show current positions along the bottom
set scrolloff=5                 " Start scrolling this number of lines from top/bottom
set shortmess+=c                " Don't pass messages to ins-completion-menu
set signcolumn=yes              " Always show sign column to the left
set termguicolors               " Enable 24-bit RGB colors
set whichwrap+=<,>,h,l          " make cursor keys and h,l wrap over line endings
set wildmenu                    " Show suggestions on TAB for some commands

let g:sonokai_better_performance = 1
let g:sonokai_colors_override = {'bg0': ['#2a2a2a', '235']} " darker background
colorscheme sonokai

" override colors for matching parens
highlight MatchParen gui=bold guibg=NONE guifg=#ef5939
" override colors for colorcolumn
highlight ColorColumn guibg=#333333

" vim-airline/vim-airline
let g:airline_theme='sonokai'
let g:airline#extensions#tabline#enabled = 1        " Enhanced top tabline
let g:airline#extensions#tabline#buffer_nr_show = 1 " Show buffer number in tabline
let g:airline#extensions#lsp = 1
let g:airline_powerline_fonts = 1                   " Use powerline fonts (requires local font)
let g:airline_section_b = airline#section#create_right(['filetype']) " filetype instead of git branch in section B
" IMPORTANT: For utf-8 this is the Unicode code point, not the hex byte sequence!
let g:airline_section_x = airline#section#create(['0x%04.5B']) " hex character code instead of filetype in section X
" }}}
" Plugin Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lspsaga Plugin settings {{{
lua << EOF
require("lspsaga").setup({
  request_timeout = 5000,
  diagnostic = {
    show_layout = 'normal',
    show_normal_height = 0.5,
    extend_relatedInformation = true,
    keys = {
      exec_action = 'o',
      quit = 'q',
      toggle_or_jump = '<cr>',
      quit_in_show = {'q', '<esc>'},
    },
  },
  definition = {
    keys = {
      edit = '<C-c>o',
      vsplit = '<C-c>v',
      split = '<C-c>s',
      tabe = '<C-c>t',
      quit = 'q',
      close = '<C-c>k',
    }
  },
  finder = {
    max_height = 0.4,
    left_width = 0.3,
    default = 'def+ref+imp',
    layout = 'normal',
    keys = {
      toggle_or_open = 'o',
      vsplit = 'v',
      split = 's',
      quit = 'q',
      close = '<c-c>k'
    },
  },
  lightbulb = {
    virtual_text = false,
  },
  outline = {
    win_width = 60,
    win_position = 'right',
    auto_preview = false,
    auto_close = true,
    layout = 'normal',
    keys = {
      toggle_or_jump = '<cr>',
      quit = 'q',
    },
  },
  rename = {
    auto_save = true,
  },
  symbol_in_winbar = {
    enable = false,
  },
  ui = {
    title = false,
  },
})
EOF
" }}}
" nvim-tree {{{
lua << EOF
require('nvim-tree').setup({
  view = {
    width = 50,
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', '+', api.tree.change_root_to_node, { desc='nvim-tree: CD', buffer=bufnr, noremap=true, silent=true, nowait=true})
    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.preview, { desc='nvim-tree: Open Preview', buffer=bufnr, noremap=true, silent=true, nowait=true})
  end
})
-- If only 1 window + nvim-tree is open, :bd makes nvim-tree go "full screen".
-- It should instead behave is if it wasn't opened, see :help :bd
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    -- Only 1 window with nvim-tree left: we probably closed a file buffer
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      local api = require('nvim-tree.api')
      vim.defer_fn(function()
        -- close nvim-tree: will go to the last buffer used before closing
        api.tree.toggle({find_file = true, focus = true})
        -- re-open nivm-tree
        api.tree.toggle({find_file = true, focus = true})
        -- nvim-tree is still the active window. Go to the previous window.
        vim.cmd("wincmd p")
      end, 0)
    end
  end
})
EOF
" }}}
" plasticboy/vim-markdown {{{
let g:vim_markdown_folding_disabled=1   " No folding for markdown files
let g:vim_markdown_toc_autofit=1        " Make :Toc window autofit
" JSON
let g:vim_json_conceal = 0  " do not conceal e.g. quotes in JSON
" }}}
" zen-mode {{{
lua << EOF
require('zen-mode').setup({})
EOF
" }}}
" }}}
" LSP init {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF

-- Uncomment to create log in ~/.cache/nvim/lsp.log
-- vim.lsp.set_log_level("debug")

-- Manages/installs external LSP servers. We don't install via :Mason to
-- keep all configurations in this file.
require("mason").setup({
  ui = {
    keymaps = {
      apply_language_filter = "<M-f>",
    },
  },
})

-- Auto-installs and updates mason packages
require("mason-tool-installer").setup({
  ensure_installed = {
    -- For Java we use nvim-jdtls and not nvim-lspconfig. So we can't rely on
    -- mason-lspconfig's auto installation.
    "jdtls",
    "java-test",
  }
})
EOF
" }}}
" Key Mappings {{{
"  - See ':h index' for a list of built in commands and mappings
"  - <Plug> is a pseudo-mapping that must be remapped (i.e. must not use noremap)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set pastetoggle=<F11>     " toggle paste mode (no autoindenting)
let mapleader = ","       " Map <leader> to , instead of default \

" let which-key create mappings
lua <<EOF
local whichkey = require('which-key')
whichkey.setup({})

-- Normal mode
whichkey.register({
  ['<F11>'] = { '<Cmd>ZenMode<CR>', 'Toggle ZenMode'},
  ['<C-h>'] = { '<Cmd>bprevious<CR>', 'Previous buffer'},
  ['<C-l>'] = { '<Cmd>bnext<CR>', 'Next buffer'},
  ['<A-n>'] = { '<Cmd>cnext<CR>', 'Next quickfix error'},
  ['<A-p>'] = { '<Cmd>cprevious<CR>', 'Previous quickfix error'},
  vp = {']p', 'Paste below with indent'},
  vP = {']P', 'Paste above with indent'},

  g = {
    ['*'] = { 'Partial search current word forward'},
    ['#'] = { 'Partial search current word backward'},
    ['0'] = { '^', 'First char in current line'},
    d = { '<Cmd>Lspsaga peek_definition<CR>', 'Goto definition (float)'},
    D = { '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Goto definition (win)'},
    n = { '<Cmd>LspNextError<CR>', 'Goto next error'},
    p = { '<Cmd>LspPrevError<CR>', 'Goto prev error'},
  },

  ['<leader>'] = {
    d = {'<Cmd>bdelete<CR>', 'Delete buffer'},
    q = { '<Cmd>cclose<CR>', 'Close quickfix' },
    t = { '<Cmd>NvimTreeFindFileToggle<CR>', 'Toggle Nvim Tree' },

    s = {
      name = 'LSP',
      a = { '<Cmd>Lspsaga code_action<CR>', 'code action'},
      c = { '<Cmd>Lspsaga incoming_calls<CR>', 'incoming calls'},
      C = { '<Cmd>Lspsaga outgoing_calls<CR>', 'outgoing calls'},
      d = { '<Cmd>Lspsaga show_line_diagnostics<CR>', 'diagnostics (line)'},
      D = { '<Cmd>Lspsaga show_buf_diagnostics<CR>', 'diagnostics (buffer)'},
      f = { '<Cmd>Lspsaga finder<CR>', 'Finder'},
      i = { '<Cmd>LspInfo<CR>', 'Info'},
      o = { '<Cmd>Lspsaga outline<CR>', 'Toggle outline'},
      r = { '<Cmd>Lspsaga rename<CR>', 'rename'},
      R = { '<Cmd>LspRestart<CR>', 'restart'},
    },
  },

  ['<space>'] = {
    e = { '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Open diagnostic float' },
    h = { '<Cmd>WhichKey "" n<CR>', 'Show all normal mode mappings' },
    p = {
      name = 'Manage plugins',
      c = { '<Cmd>PlugClean<CR>', 'Remove unlisted'},
      d = { '<Cmd>PlugDiff<CR>', 'Show last updates'},
      s = { '<Cmd>PlugStatus<CR>', 'Show status'},
      u = { '<Cmd>PlugUpdate<CR>', 'Update all'},
      U = { '<Cmd>PlugUpgrade<CR>', 'Upgrade vim-plug'},
    },
  },
})

-- Insert mode
whichkey.register({
  jj = {'<Esc>', 'Escape'},
}, {mode = 'i'})

-- Select mode
whichkey.register({
  jj = {'<Esc>', 'Escape'},
}, {mode = 's'})

-- Command line mode
whichkey.register({
  ['<C-p>'] = { '<up>', 'Search', silent=false},
}, {mode = 'c'})

EOF
" }}}
" Commands {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command -bang LspPrevError
  \ lua require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })

command -bang LspNextError
  \ lua require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
" }}}
" vim: fdm=marker


