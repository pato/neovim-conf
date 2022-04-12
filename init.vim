call plug#begin()
" Install fzf for fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" My favorite theme
Plug 'morhetz/gruvbox'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Fuzzy finder
" Optional
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Status lines
Plug 'vim-airline/vim-airline'

" Toggle comments for all languages
Plug 'tpope/vim-commentary'

" Provide git tools
Plug 'tpope/vim-fugitive'

" Allow deleting/adding based on surrounding characters
Plug 'tpope/vim-surround'

" Filetree plugin
Plug 'preservim/nerdtree'

call plug#end()

colorscheme gruvbox 

" For finger fumbling (thanks rperce)
command! W w
command! Wq wq
command! WQ wq
command! Q q
command! Wa wa
command! WA wa

" Enable mouse mode in all modes (GASP)
set mouse=a

" Enable persistent undo
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set nrformats-=octal
set laststatus=2
set ruler
set wildmode=longest,list,full
set wildmenu

" Incrementally display search results
set incsearch
" Highlight search results
set hlsearch
" When searching try to be smart about cases
set smartcase
" Show matching brackets when text indicator is over them
set showmatch

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

" Open new splits to right and bottom
set splitbelow
set splitright

" Turn on the detection, plugin, and indent configurations all at once
filetype plugin indent on

" Turn on syntax highlighting
syntax on

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" Rust-analyzer shortcuts
" Code navigation shortcuts
nnoremap <silent> <c-]>        <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K            <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD           <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k>        <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD          <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr           <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0           <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW           <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd           <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga           <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <space>rn    <cmd>lua vim.lsp.buf.rename()<CR>

" NERD Tree
nnoremap <leader>tn :NERDTreeFocus<CR>
nnoremap <leader>tt :NERDTreeToggle<CR>
nnoremap <leader>tf :NERDTreeFind<CR>

" FZF
nnoremap <leader>fo :GFiles<CR>
nnoremap <leader>ff :Ag<CR>

" Commentary 
nnoremap <leader>cc :Commentary<CR>
