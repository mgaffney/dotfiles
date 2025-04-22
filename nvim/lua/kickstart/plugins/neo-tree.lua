-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	'nvim-neo-tree/neo-tree.nvim',
	branch = "v3.x",
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
		'MunifTanjim/nui.nvim',
	},
	lazy = false,
	cmd = 'Neotree',
	keys = {
		{ '[oe', ':Neotree source=filesystem reveal=true position=left action=show<CR>',               desc = 'Explorer on',     silent = true },
		{ ']oe', ':Neotree source=filesystem reveal=true position=left action=close<CR>',              desc = 'Explorer off',    silent = true },
		{ 'yoe', ':Neotree source=filesystem reveal=true position=left toggle action=show<CR>',        desc = 'Explorer toggle', silent = true },
		{ 'yoS', ':Neotree source=document_symbols reveal=true position=right toggle action=show<CR>', desc = 'Symbols toggle',  silent = true },
	},
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		filesystem = {
			window = {
				mappings = {
					['\\'] = 'close_window',
					["Z"] = "expand_all_nodes",
				},
			},
		},
	},
}
