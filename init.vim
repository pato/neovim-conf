call plug#begin()
" Install fzf for fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Faster load times
Plug 'lewis6991/impatient.nvim'

" My favorite themes
Plug 'morhetz/gruvbox'
Plug 'savq/melange'
Plug 'shaunsingh/nord.nvim'
Plug 'andersevenrud/nordic.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/edge'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

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

" For replacing vim's select ui
Plug 'nvim-lua/popup.nvim'

" Status lines
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'

" Toggle comments for all languages
Plug 'tpope/vim-commentary'

" Provide git tools (such as :Git, :Git blame)
Plug 'tpope/vim-fugitive'

" Allow deleting/adding based on surrounding characters
Plug 'tpope/vim-surround'

" Allow repeating plugin actions (such as surround actions)
Plug 'tpope/vim-repeat'

" Filetree plugin
Plug 'preservim/nerdtree'

" Easymotion for quick movement
"Plug 'Lokaltog/vim-easymotion' (disabling since it breaks the lsp and i wasnt using it)

" Toggle-term for more ergonomic terminal experience
Plug 'akinsho/toggleterm.nvim'

" Telescope for fuzzy pickers on steroids
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Popui for better select and input (needs popfix)
Plug 'hood/popui.nvim'
Plug 'RishabhRD/popfix'

" For automatically closing parans, brackets, quotes, etc...
" Plug 'jiangmiao/auto-pairs' -- old one
Plug 'windwp/nvim-autopairs'

" Tree Sitter for AST level parsing of languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" Fancy startscreen
Plug 'goolord/alpha-nvim'

" Icons and pane view of errors (trouble)
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

" Highlight the word under the cursor
Plug 'RRethy/vim-illuminate'

" Manage LSPs, debuggers, and linters (use :Mason to install and update them)
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Faster movement
" Plug 'ggandor/leap.nvim' (disabled, see note further down)

" Magit (emacs style)
Plug 'TimUntersberger/neogit'

" Gutter Git Status (also used for undoing/staging/diffing hunks)
Plug 'airblade/vim-gitgutter'

" Diff view and merge tool
Plug 'sindrets/diffview.nvim'

" Useful for managing buffers (e.g., closing those not visible `:Bdelete other`)
Plug 'Asheq/close-buffers.vim'

" Better diagnostic lines
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

" Purely aesthetic smooth cursor
Plug 'gen740/SmoothCursor.nvim'

" Purely aesthetic animation for when im bored
" :CellularAutomaton make_it_rain/game_of_life
Plug 'eandrju/cellular-automaton.nvim'

" For remembering my key binds
" See marks with ` or '
" See registers with "
Plug 'folke/which-key.nvim'

" CodeGPT to add ChatGPT ! (you'll need to set your OPENAI_API_KEY environment variable)
Plug 'MunifTanjim/nui.nvim'
Plug 'dpayne/CodeGPT.nvim'

call plug#end()

lua require('impatient')

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Turn on syntax highlighting
syntax on

" Turn on the detection, plugin, and indent configurations all at once
filetype plugin indent on

" Set my favorite colorscheme
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_contrast_light = 'soft'
" colorscheme gruvbox

let g:edge_style = 'aura'
let g:edge_better_performance = 1
let g:edge_diagnostic_text_highlight = 1
let g:edge_diagnostic_virtual_text = 'colored'
let g:edge_enable_italic = 1
let g:airline_theme = 'edge'
" colorscheme edge

let g:nord_underline_option = 'none'
let g:nord_italic = v:true
let g:nord_italic_comments = v:true
let g:nord_minimal_mode = v:false
let g:nord_alternate_backgrounds = v:false
" colorscheme nord


let g:airline_theme = 'embark'
" colorscheme embark

let g:airline_theme = 'catppuccin'
colorscheme catppuccin-frappe

" let g:gruvbox_material_background = 'hard'
" let g:gruvbox_material_better_performance = 1
" let g:gruvbox_material_diagnostic_text_highlight = 1
" let g:airline_theme = 'gruvbox_material'
" let g:gruvbox_material_enable_italic = 1
" colorscheme gruvbox-material
" set background=dark

" Enable light background if it's during the day
" fun! s:set_bg(timer_id)
"   if strftime("%H") >= 9 && strftime("%H") < 20
"     set background=light
"   else
"     set background=dark
"   endif
" endfun
" call timer_start(1000 * 60, function('s:set_bg'), {'repeat': -1})
" call s:set_bg(0)

" Add a function (and command of it) to remove trailing whitespace
function FixTrailing()
  :%s/\s\+$//e
endfunction
command -bar FixTrailing call FixTrailing()


" For finger fumbling (thanks rperce)
command! W w
command! Wq wq
command! WQ wq
command! Q q
command! Wa wa
command! WA wa

" Enable mouse mode in all modes (GASP)
set mouse=a

" Enable hybrid line numbers (show absolute for current line and relative
" otherwise)
set number relativenumber

" Enable persistent undo
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

set autoindent expandtab tabstop=2 shiftwidth=2
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
set ignorecase 
set smartcase
" Show matching brackets when text indicator is over them
set showmatch

" Used to clear the highlighting of :set hlsearch.
"if maparg('<C-L>', 'n') ==# ''
if maparg('<Enter>', 'n') ==# ''
  "nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
  nnoremap <silent> <Enter> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><Enter>
endif

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

" Open new splits to right and bottom
set splitbelow
set splitright

" Zoom in and zoom out of split panes
noremap Zz <c-w>_ \| <c-w>\|
noremap Zo <c-w>=

" Make Carlos happy with split pane navigation (without needing C-w first)
"nnoremap <C-h> <C-w>h
"nnoremap <C-l> <C-w>l
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Super hack but I cannot for the life of me get <C-U> to give vim the correct
" key code (it always outputs <BS>)
" So let's map <C-E> to <C-U>
nnoremap <C-E> <C-U>

" Sets the cursor to a vertical line for insert mode, underline for replace mode, and block for normal mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
"autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Auto FMT after save
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 2000)

" Close NERDTree after opening a file
let NERDTreeQuitOnOpen=1

" Goto previous/next diagnostic warning/error
nnoremap <silent> g. <cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" Rust-analyzer shortcuts
" Code navigation shortcuts
"nnoremap <silent> <c-]>        <cmd>Telescope lsp_definitions<CR>
"nnoremap <silent> K            <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> K            <cmd>RustHoverActions<CR>
nnoremap <silent> gi           <cmd>Telescope lsp_implementations<CR>
nnoremap <silent> <c-k>        <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gd          <cmd>Telescope lsp_type_definitions<CR>
nnoremap <silent> gr           <cmd>Telescope lsp_references<CR>
nnoremap <silent> gW           <cmd>Telescope lsp_document_symbols<CR>
nnoremap <silent> gw           <cmd>Telescope lsp_dynamic_workspace_symbols<CR>
nnoremap <silent> gd           <cmd>Telescope lsp_definitions<CR>
nnoremap <silent> gD           <cmd>RustOpenExternalDocs<CR>
nnoremap <silent> ga           <cmd>lua vim.lsp.buf.code_action()<CR>
xnoremap <silent> ga           <cmd>lua vim.lsp.buf.range_code_action()<CR>
nnoremap <silent> ge           <cmd>Telescope diagnostics<CR>
nnoremap <silent> <space>rn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <space>f     <cmd>lua vim.lsp.buf.formatting()<CR>

" Rust go-to
nnoremap <leader>gc 	       <cmd>RustOpenCargo<CR>
nnoremap <leader>gm 	       <cmd>RustParentModule<CR>

" Rust actions
nnoremap <leader>rr 	       <cmd>RustRunnables<CR>
" Annoremap <leader>rl 	       <cmd>RustLastRun<CR> " this is not working upstream yet
nnoremap <leader>rl 	       <cmd>Telescope resume<CR>

" Telescope-only bindings
nnoremap <leader>gl 	       <cmd>Telescope resume<CR>

" Diffview
nnoremap <leader>dd 	       <cmd>DiffviewOpen<CR>
nnoremap <leader>dm 	       <cmd>DiffviewOpen main...<CR>
nnoremap <leader>dc 	       <cmd>DiffviewClose<CR>

" NERD Tree
nnoremap <leader>tn :NERDTreeFocus<CR>
nnoremap <leader>tt :NERDTreeToggle<CR>
nnoremap <leader>tf :NERDTreeFind<CR>

" FZF
nnoremap <leader>fo :Telescope find_files<CR>
nnoremap <leader>fg :Telescope git_files<CR>
nnoremap <leader>ff :Telescope live_grep<CR>
nnoremap <C-P>      <cmd>Telescope find_files<CR>

" Commentary
" maps gc in visual mode to toggle

" Commands
nnoremap <leader>cc <cmd>TermExec cmd="cargo check --all-targets"<CR>
nnoremap <leader>ct <cmd>TermExec cmd="cargo nextest run"<CR>
nnoremap <leader>cs <cmd>TermExec cmd="git status" go_back=0<CR>
nnoremap <leader>gs <cmd>Telescope git_status<CR>
nnoremap <leader>gb <cmd>Telescope git_branches<CR>
nnoremap <leader>gt <cmd>Neogit kind=vsplit<CR>

" GitGutter and git hunk operations 
"
nnoremap <space>vs <cmd>GitGutterStageHunk<cr>
nnoremap <space>vu <cmd>GitGutterUndoHunk<cr>
nnoremap <space>vn <cmd>GitGutterNextHunk<cr>
nnoremap <space>vp <cmd>GitGutterPrevHunk<cr>
nnoremap <space>vv <cmd>GitGutterPreviewHunk<cr>
nnoremap <space>vf <cmd>GitGutterFold<cr>

" Trouble (pretty errors) pane
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>

" Termainal mode mappings
"
" Map Esc to bring us back to normal mode when in terminal
tnoremap <Esc> <C-\><C-n>

" Use treesitter for folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Disable folds...
set nofoldenable

" Open all folds on open
" autocmd BufReadPost,FileReadPost * normal zR

lua <<EOF
-- <- -- -- -- -- -- LUA TIME -- -- -- -- -- -> --

-- Setup mason to manage LSPs, debuggers, and linters
require("catppuccin").setup({
  integrations = {
    mason = true,
    neogit = true,
    cmp = true,
    telescope = true,
    lsp_trouble = true,
    illuminate = true,
    treesitter = true,
    treesitter_context = true,
  }
})

require("mason").setup()

-- Setup dashboard
-- require'alpha'.setup(require'alpha.themes.dashboard'.config)
require'alpha'.setup(require'alpha.themes.startify'.config)

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        -- hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=> ",
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
                -- rust-analyzer (https://github.com/rust-lang/rust-analyzer/pull/13699) caused a regression in rust-tools, workaround: (https://github.com/simrat39/rust-tools.nvim/issues/300)
                -- inlayHints = {
                --   locationLinks = false
                -- },
		-- rustfmt = {
		--     overrideCommand = "cargo +nightly fmt"
		-- },
            }
        }
    },
}

require('rust-tools').setup(opts)

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
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
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
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

-- Setup toggle-term
require("toggleterm").setup{
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_terminals = true,
  start_in_insert = true,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  persist_size = true,
}

local Terminal  = require('toggleterm.terminal').Terminal

-- Set up telescope-ui-select
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown { }
    }
  }
}
require("telescope").load_extension("ui-select")

-- Set up popui.nvim
-- vim.ui.select = require"popui.ui-overrider-- -- switched to telescope-ui-select
vim.ui.input = require"popui.input-overrider"


-- Configure tree Sitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Configure treesitter context so it shows which file/function i'm in
require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
        },
    },
}

-- Configure the trouble plugin
require("trouble").setup {}

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}

-- Enable auto pairs
require("nvim-autopairs").setup({
  check_ts = true,
})

-- Enable leap (disabled because it conflicts with delete)
-- lua require('leap').add_default_mappings()

-- Enable Magit
local neogit = require('neogit')
neogit.setup {}

-- Disabling this becuase virtual text support isn't that great yet. Try again later.
-- Enable lsp_lines for better diagnostics
-- vim.diagnostic.config({
--   virtual_text = false,
--   virtual_lines = { only_current_line = true },
-- })
-- vim.keymap.set(
--   "",
--   "<Leader>ll",
--   require("lsp_lines").toggle,
--   { desc = "Toggle lsp_lines" }
-- )
-- 
-- require("lsp_lines").setup()

-- Configure smooth cursor
require('smoothcursor').setup{
  fancy = {
    enable = true
  }
}

vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup {
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20,
    }
  }
}

-- Configure CodeGPT 
require("codegpt.config")

vim.g["codegpt_commands"] = {
["completion"] = {
    callback_type = "code_popup",
},
["code-edit"] = {
    callback_type = "code_popup",
},
["doc"] = {
    callback_type = "code_popup",
},
["opt"] = {
    callback_type = "code_popup",
},
["tests"] = {
    callback_type = "code_popup",
},
["chat"] = {
    callback_type = "text_popup",
},
}


-- Enable the status line
local colors = {
  red = '#ca1243',
  grey = '#314549',
  black = '#383a42',
  white = '#f3f3f3',
  other = '#263238',
  light_green = '#83a598',
  orange = '#fe8019',
  green = '#8ec07c',
}

local theme = {
  normal = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white, bg = colors.other},
    z = { fg = colors.white, bg = colors.black },
  },
  insert = { a = { fg = colors.black, bg = colors.light_green } },
  visual = { a = { fg = colors.black, bg = colors.orange } },
  replace = { a = { fg = colors.black, bg = colors.green } },
}

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = ''
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < 'x'
    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.other } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
    end
  end
  return sections
end

local function search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function modified()
  if vim.bo.modified then
    return '+'
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return '-'
  end
  return ''
end

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = process_sections {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'error' },
        diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'warn' },
        diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
      },
      { 'filename', file_status = false, path = 1 },
      { modified, color = { bg = colors.red } },
      {
        '%w',
        cond = function()
          return vim.wo.previewwindow
        end,
      },
      {
        '%r',
        cond = function()
          return vim.bo.readonly
        end,
      },
      {
        '%q',
        cond = function()
          return vim.bo.buftype == 'quickfix'
        end,
      },
    },
    lualine_c = {
      'lsp_progress'
    },
    lualine_x = {},
    lualine_y = { search_result, 'filetype' },
    lualine_z = { '%l:%c', '%p%%/%L' },
  },
  inactive_sections = {
    lualine_c = { '%f %y %m' },
    lualine_x = {},
  },
}
--require('lualine').setup()
