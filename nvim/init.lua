-- require("options")
-- require("keymaps")
-- require("config.lazy")
-- require("lazy").setup("plugins")

--[[
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    { "calind/selenized.nvim" }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
--]]

-- vim.cmd.colorscheme("selenized")

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true -- indent at the same level of the previous line
vim.opt.shiftround = true -- round indents to multiple of shiftwidth

vim.opt.clipboard = "unnamed"
-- vim.opt.scrolloff = 999

vim.opt.background = "dark" -- Assume a dark background
-- colorscheme selenized
vim.opt.encoding = "utf-8"  -- The encoding displayed
-- scriptencoding utf-8
-- vim.opt.nojoinspaces			-- One space between sentences not two
-- vim.opt.shortmess+="cfilmnrxoOtT"	-- abbrev. of messages (avoids 'hit enter')
-- vim.opt.virtualedit = "onemore"	-- allow for cursor beyond last character
vim.opt.history = 10000
vim.opt.clipboard = "unnamed" -- Yanks go on clipboard instead.
vim.opt.autowrite = true      -- Writes on make/shell commands
vim.opt.cursorline = true     -- Highlight the line the cursor is on
vim.opt.errorbells = false
vim.opt.visualbell = true
-- vim.opt.t_vb=
vim.opt.virtualedit = "block"             -- Allow for block cursor in visual mode
vim.opt.inccommand = "split"              -- Show live preview of substitution

vim.opt.incsearch = true                  -- find as you type search
vim.opt.hlsearch = true                   -- highlight search terms
vim.opt.ignorecase = true                 -- case insensitive search
vim.opt.smartcase = true                  -- case sensitive when uc present
vim.opt.winminheight = 0                  -- windows can be 0 line high
vim.opt.smarttab = true                   -- sw at the start of the line, sts everywhere else

vim.opt.timeoutlen = 1200                 -- A little bit more time for macros
vim.opt.ttimeoutlen = 50                  -- Make Esc work faster
vim.opt.wildmenu = true                   -- show list instead of just completing
vim.opt.wildmode = "longest,list:longest" -- tab completion like zsh's
vim.opt.gdefault = true                   -- the /g flag on :s substitutions by default

vim.opt.diffopt = "filler,vertical"
vim.opt.termguicolors = true

-- Save undo history
vim.opt.undofile = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
-- vim.opt.timeoutlen = 300

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear [H]ighlights" })

vim.keymap.set("n", "z0", "zcz0", { noremap = true, silent = true, desc = "Open fold" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- vim.keymap.set("n", "<F1>", "<ESC>", { noremap = true, silent = true, desc = "Escape" })

vim.cmd([[
function! ToggleBg()
	if &background == 'dark'
		set bg=light
	else
		set bg=dark
	endif
endfunc

function! ToggleNumbers()
	if(&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc

noremap <F1> <Esc>
nnoremap <F2> :call ToggleBg()<cr>
nnoremap <F3> :call ToggleNumbers()<cr>
nnoremap <F4> :ToggleWhitespace<cr>

vnoremap < <gv
vnoremap > >gv
cnoremap cwd lcd %:p:h
cnoremap cd. lcd %:p:h

cnoremap cpwd lcd %:p:h/..
cnoremap cpd. lcd %:p:h/..

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

let g:projectionist_heuristics = {
	\ '*.go': {
	\   '*.go': {
	\       'alternate': '{}_test.go',
	\       'type': 'source'
	\   },
	\   '*_test.go': {
	\       'alternate': '{}.go',
	\       'type': 'test'
	\   },
	\ },
	\ '*.sql': {
	\   '*.up.sql': {
	\       'alternate': '{}.down.sql',
	\       'type': 'source'
	\   },
	\   '*.down.sql': {
	\       'alternate': '{}.up.sql',
	\       'type': 'source'
	\   },
	\ }
\ }

augroup templates
	autocmd!
	autocmd BufNewFile *.* silent! execute '0r $HOME/.vim/templates/template.'.expand("<afile>:e")
	autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END

augroup zips
	autocmd!
	autocmd BufReadCmd *.jar,*.xpi,*.sar,*.war,*.ear,*.mar,*.aar,*.ipa,*.epub call zip#Browse(expand("<amatch>"))
augroup END

augroup plists
	autocmd!
	autocmd BufReadCmd *.cat call plist#Read(1) | call plist#ReadPost()
augroup end

augroup fileconfigs
	autocmd!
	autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
	autocmd BufNewFile,BufRead *.rfc setlocal filetype=markdown
augroup END

function! CopyMatches(reg)
	let hits = []
	%s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
	let reg = empty(a:reg) ? '+' : a:reg
	execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

let g:vim_json_syntax_conceal = 0
let g:markdown_fenced_languages = ['html', 'python',
	\ 'bash=sh', 'go', 'json', 'javascript', 'sql', 'zsh', 'vim']
let g:markdown_syntax_conceal = 0
let g:markdown_folding = 1

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

au BufWritePre,FileWritePre * if @% !~# '\(://\)' | call mkdir(expand('<afile>:p:h'), 'p') | endif

let g:github_enterprise_urls = ['github.com', 'github.ibm.com']

highlight NonText guifg=#4a4a59 guibg=bg
highlight SpecialKey guifg=#4a4a59 guibg=bg
highlight Folded cterm=none gui=none
highlight FloatBorder guifg=#073642 guibg=#073642
highlight goSameId gui=reverse guifg=#268bd2

highlight SpellBad term=underline cterm=underline
highlight SpellCap term=underline cterm=underline
highlight SpellRare term=underline cterm=underline
highlight SpellLocal term=underline cterm=underline

]])
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  "tpope/vim-abolish",
  "tpope/vim-characterize",
  "tpope/vim-dadbod",
  "tpope/vim-dispatch",
  "tpope/vim-eunuch",
  "tpope/vim-git",
  "tpope/vim-markdown",
  "tpope/vim-obsession",
  "tpope/vim-projectionist",
  "tpope/vim-repeat",
  "tpope/vim-rhubarb",
  "tpope/vim-scriptease",
  "tpope/vim-sensible",
  "tpope/vim-speeddating",
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
  "tpope/vim-vinegar",
  "junegunn/gv.vim",
  "junegunn/goyo.vim",
  "junegunn/limelight.vim",
  "github/copilot.vim",
  "airblade/vim-gitgutter",
  "idanarye/vim-merginal",
  "aymericbeaumet/vim-symlink",
  "moll/vim-bbye", -- optional dependency
  "mbbill/undotree",
  "mileszs/ack.vim",
  {
    "junegunn/vim-easy-align",
    keys = {
      { "yga", "<Plug>(EasyAlign)", { noremap = false, silent = true, desc = "Align [a]round" } },
      { "ga",  "<Plug>(EasyAlign)", mode = "x",                                                 { noremap = false, silent = true, desc = "Align [a]round" } },
    },
  },
  "junegunn/fzf",
  {
    "junegunn/fzf.vim",
    requires = { "junegunn/fzf" },
    keys = {
      -- { "<leader>ff",  ":Files<CR>",     { noremap = true, silent = true, desc = "[f]ind [f]iles" } },
      -- { "<leader>fg",  ":GFiles<CR>",    { noremap = true, silent = true, desc = "[f]ind [g]it files" } },
      -- { "<leader>fb",  ":Buffers<CR>",   { noremap = true, silent = true, desc = "[f]ind [b]uffers" } },
      -- { "<leader>fh",  ":Helptags!<CR>", { noremap = true, silent = true, desc = "[f]ind [h]elp tags" } },
      -- { "<leader>fl",  ":Lines<CR>",     { noremap = true, silent = true, desc = "[f]ind [l]ines" } },
      -- { "<leader>fs",  ":Rg<CR>",        { noremap = true, silent = true, desc = "[f]ind [s]earch" } },
      -- { "<leader>ft",  ":BTags<CR>",     { noremap = true, silent = true, desc = "[f]ind [t]ags" } },
      -- { "<leader>fm",  ":Marks<CR>",     { noremap = true, silent = true, desc = "[f]ind [m]arks" } },
      { "<leader>fH",  ":History<CR>",  { noremap = true, silent = true, desc = "[f]ind [H]istory" } },
      -- { "<leader>f:",  ":History:<CR>",  { noremap = true, silent = true, desc = "[f]ind [:]History" } },
      -- { "<leader>f/",  ":History/<CR>",  { noremap = true, silent = true, desc = "[f]ind [/]History" } },
      -- { "<leader>fm",  ":Maps<CR>",      { noremap = true, silent = true, desc = "[f]ind [m]aps" } },
      -- { "<leader>fc",  ":Commands<CR>",  { noremap = true, silent = true, desc = "[f]ind [c]ommands" } },
      { "<leader>fgc", ":Commits<CR>",  { noremap = true, silent = true, desc = "[f]ind [g]it [c]ommits" } },
      { "<leader>fgb", ":BCommits<CR>", { noremap = true, silent = true, desc = "[f]ind [g]it [b]uffer commits" } },
      -- { "<leader>fw", ":Windows<CR>", { noremap = true, silent = true, desc = "[W]indows" } },
      -- { "<leader>fq", ":Quickfix<CR>", { noremap = true, silent = true, desc = "[Q]uickfix" } },
      -- { "<leader>fl", ":Locate<CR>", { noremap = true, silent = true, desc = "[L]ocate" } },
      -- { "<leader>fd", ":BDelete<CR>", { noremap = true, silent = true, desc = "[D]elete buffer" } },
      -- { "<leader>fo", ":FZF<CR>", { noremap = true, silent = true, desc = "[O]pen FZF" } },
    },
    --     config = function()
    --       vim.cmd([[
    -- if !exists('g:fzf_vim')
    --   let g:fzf_vim = {}
    -- endif
    -- let g:fzf_vim.commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(reset)· %C(cyan)%cr %C(reset)· %C(reset)%C(yellow)%an%C(reset)"'
    --
    -- ]])
    --     end,

  },
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      { "gst",         ":vertical :G<CR>",     { noremap = true, silent = true, desc = "Open [G]it [ST]atus" } },
      { "<leader>gb",  ":G blame<CR>",         { noremap = true, silent = true, desc = "Open [G]it [B]lame" } },
      { "<leader>gll", ":vertical :G log<CR>", { noremap = true, silent = true, desc = "Open [G]it [LL]og" } },
      {
        "<leader>glf",
        ":vertical :G log --name-only<CR>",
        { noremap = true, silent = true, desc = "Open [G]it [L]og show [F]iles" },
      },
      {
        "<leader>glm",
        ":vertical :G log --author='Michael Gaffney'<CR>",
        { noremap = true, silent = true, desc = "Open [G]it [L]og [M]e" },
      },
      {
        "<leader>glt",
        ":vertical :G log --author='Messier'<CR>",
        { noremap = true, silent = true, desc = "Open [G]it [L]og [T]im" },
      },
    },
  },
  {
    "lifepillar/pgsql.vim",
    config = function()
      vim.g.sql_type_default = "pgsql"
    end,
  },
  "tmux-plugins/vim-tmux",
  {
    "christoomey/vim-tmux-navigator",
    event = "VimEnter",
    config = function()
      vim.cmd([[
if exists('$TMUX')
	nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
	let g:tmuxline_separators = {
		\ 'left' : '',
		\ 'left_alt': '',
		\ 'right' : '',
		\ 'right_alt' : '',
		\ 'space' : ' '}
	let g:tmuxline_preset = {
		\ 'a': ['#S'],
		\ 'b': '#W',
		\ 'c': ['#{pane_current_command}'],
		\ 'cwin': ['#I', '#W'],
		\ 'win': ['#I', '#W'],
		\ 'x': '#{cursor_y}: #{cursor_x}',
		\ 'y': [ '%l:%M', '%a %b %e'],
		\ 'z': '#h'}
endif
]])
    end,
  },

  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        "nvim-telescope/telescope-fzf-native.nvim",

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = "make",

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require("telescope").setup({
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
      vim.keymap.set("n", "<leader>fm", builtin.keymaps, { desc = "[F]ind key[M]aps" })
      vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "[F]ind [C]ommands" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
      vim.keymap.set("n", "<leader>f:", builtin.command_history, { desc = "[F]ind [:]history" })
      vim.keymap.set("n", "<leader>f/", builtin.search_history, { desc = "[F]ind [/]history" })

      vim.keymap.set("n", "<leader>fgf", builtin.git_files, { desc = "[F]ind [G]it [F]iles" })
      vim.keymap.set("n", "<leader>sgc", builtin.git_commits, { desc = "[F]ind [G]it [C]ommits" })
      vim.keymap.set("n", "<leader>sgb", builtin.git_bcommits, { desc = "[F]ind [G]it [B]commits" })

      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader>fl", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "find string in open buffers",
        })
      end, { desc = "[f]ind [l]ines in open buffers" })

      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({
          no_ignore = true,
        })
      end, { desc = "[F]ind [F]iles" })

      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

      -- vim.keymap.set("n", "<leader>sv", builtin.buffers,       { desc = "[ ] Find existing buffers" })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set("n", "<leader>sb", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[S]earch [B] Fuzzily search in current buffer" })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end, { desc = "[S]earch [/] in Open Files" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[S]earch [N]eovim files" })
    end,
  },
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta",   lazy = true },
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim",       opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Find callers for the word under your cursor.
          map("grc", function()
              require("telescope.builtin").lsp_incoming_calls(
                { fname_width = 70 }
              )
            end,
            "[G]oto [C]allers")

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup =
                vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                unusedvariable = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },


        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        -- lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        version = 'v2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },

    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      -- Disable cmdline
      cmdline = { enabled = false },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" }
  },

  {
    "mgaffney/selenized.nvim",
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("selenized")
    end,
  },

  --[[
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("tokyonight-night")

			-- You can configure highlights by doing something like:
			-- vim.cmd.hi 'Comment gui=none'
		end,
	},
  --]]

  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "comment",
        "go",
        "gotmpl",
        "gomod",
        "gosum",
        "gowork",
        "proto",
        "sql",
        "json",
        "dockerfile",
        "yaml",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitattributes",
        "gitignore",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  -- {
  --   "hedyhli/outline.nvim",
  --   config = function()
  --     -- Example mapping to toggle outline
  --     vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
  --       { desc = "Toggle Outline" })
  --
  --     require("outline").setup {
  --       -- Your setup opts here (leave empty to use defaults)
  --     }
  --   end,
  -- },
  {
    "vim-airline/vim-airline",
  },
  {
    "vim-airline/vim-airline-themes",
    requires = { "vim-airline/vim-airline" },
    config = function()
      vim.cmd([[
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_powerline_fonts=1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#obsession#indicator_text = '' " U+F130 (microphone)
let g:airline_symbols.notexists = ' ' "thinspace U+F059 (Question mark - as in 'where is it')
let g:airline_symbols.dirty = ' ' "thinspace + storm cloud
let g:airline_left_sep = '' " U+E0B0
let g:airline_right_sep = '' " U+E0B2
let g:airline_right_alt_sep = '' " U+E0B3
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_selenized_normal_green = 0
if exists('$TMUX')
	let g:airline#extensions#tmuxline#enabled = 0
endif

]])
    end,
  },
  "aklt/plantuml-syntax",
  "cespare/vim-toml",
  "chrisbra/csv.vim",
  "darfink/vim-plist",
  "ekalinin/Dockerfile.vim",
  "elzr/vim-json",
  "embear/vim-localvimrc",
  "guns/xterm-color-table.vim",
  "hashivim/vim-terraform",
  "kshenoy/vim-signature",
  "leafgarland/typescript-vim",
  "majutsushi/tagbar",
  "numToStr/Comment.nvim",
  "sindrets/diffview.nvim",
  "tomswartz07/vim-pg-explain-syntax",
  "tomtom/tcomment_vim",
  "uarun/vim-protobuf",
  "unblevable/quick-scope",
  "vim-scripts/camelcasemotion",
  "yegappan/taglist",
  "zackhsi/fzf-tags",
  "zimbatm/haproxy.vim",
  "simrat39/rust-tools.nvim",
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      vim.cmd([[

highlight ExtraWhitespace ctermbg=DarkBlue
let g:better_whitespace_filetypes_blacklist=['diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'proto', 'markdown', 'fugitive', 'html']
let g:strip_whitespace_confirm = 0
let g:strip_only_modified_lines = 1
let g:strip_whitespace_on_save = 1

]])
    end,
  },
  {
    "mhinz/vim-grepper",
    config = function()
      vim.cmd([[

let g:grepper = {}
let g:grepper.tools = ['rg', 'git', 'grep', 'ag']
nnoremap <Leader>* :Grepper -cword -noprompt<CR>
nnoremap <Leader>rg :Grepper -tool rg -grepprg rg -H --no-heading --vimgrep --sort path<CR>
nnoremap <Leader>vg :Grepper -tool rg -grepprg rg -H --no-heading --vimgrep --sort path -g '!vendor' -g '!website' -g '!ui'<CR>
set grepprg=internal

]])
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  require("kickstart.plugins.neo-tree"),
  require("kickstart.plugins.gitsigns"), -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  rocks = {
    enabled = false,
    root = vim.fn.stdpath("data") .. "/lazy-rocks",
    server = "https://nvim-neorocks.github.io/rocks-binaries/",
    -- use hererocks to install luarocks?
    -- set to `nil` to use hererocks when luarocks is not found
    -- set to `true` to always use hererocks
    -- set to `false` to always use luarocks
    hererocks = false,
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
