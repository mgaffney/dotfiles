-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{
		"lukas-reineke/headlines.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = true,
		config = function()
			local bg      = "#103c48"
			local red     = '#fa5750'
			local green   = '#75b938'
			local yellow  = '#dbb32d'
			local blue    = '#4695f7'
			local magenta = '#f275be'
			local cyan    = '#41c7b9'
			local orange  = '#ed8649'
			local violet  = '#af88eb'

			vim.api.nvim_set_hl(0, "Headline1", { fg = red, bg = bg })
			vim.api.nvim_set_hl(0, "Headline2", { fg = green, bg = bg })
			vim.api.nvim_set_hl(0, "Headline3", { fg = yellow, bg = bg })
			vim.api.nvim_set_hl(0, "Headline4", { fg = magenta, bg = bg })
			vim.api.nvim_set_hl(0, "Headline5", { fg = cyan, bg = bg })
			vim.api.nvim_set_hl(0, "CodeBlock", { bg = bg })
			vim.api.nvim_set_hl(0, "Dash", { fg = "#D19A66", bold = true })

			require("headlines").setup {
				markdown = {
					headline_highlights = { "Headline1", "Headline2", "Headline3" },
					bullet_highlights = { "Headline1", "Headline2", "Headline3" },
					bullets = { "❯", "❯❯", "❯❯❯", "❯❯❯❯", "❯❯❯❯❯" },
					dash_string = "⎯",
					fat_headlines = false,
					query = vim.treesitter.query.parse(
						"markdown",
						[[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock
            ]]
					),
				},
			}
		end,
	},

	--[[
	{
		"epwalsh/obsidian.nvim",
		name = "obsidian",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
			"headlines.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "Notes",
					path = "/Users/mgaffney/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes",
					overrides = {
						notes_subdir = "notes",
					},
				},
			},

			templates = {
				folder = "templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				-- A map for custom variables, the key should be the variable and the value a function
				substitutions = {},
			},

			daily_notes = {
				-- Optional, if you keep daily notes in a separate directory.
				folder = "daily",
				-- Optional, if you want to change the date format for the ID of daily notes.
				date_format = "%Y-%m-%d",
				-- Optional, if you want to change the date format of the default alias of daily notes.
				alias_format = "%A %B %-d, %Y",
				-- Optional, default tags to add to each new daily note created.
				default_tags = { "daily-notes" },
				-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
				template = "daily.md"
			},

			-- Where to put new notes. Valid options are
			--  * "current_dir" - put new notes in same directory as the current buffer.
			--  * "notes_subdir" - put new notes in the default notes subdirectory.
			new_notes_location = "notes_subdir",

			open_notes_in = "vsplit",

			-- Optional, customize how note IDs are generated given an optional title.
			---@param title string|?
			---@return string
			note_id_func = function(title)
				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				-- In this case a note with the title 'My new note' will be given an ID that looks
				-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
				local suffix = ""
				if title ~= nil then
					-- If title is given, transform it into valid file name.
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return tostring(os.time()) .. "-" .. suffix
			end,

		},
	}
	--]]
}

--[[
Lua Date and Time format tags
https://www.lua.org/pil/22.1.html

%a	abbreviated weekday name (e.g., Wed)
%A	full weekday name (e.g., Wednesday)
%b	abbreviated month name (e.g., Sep)
%B	full month name (e.g., September)
%c	date and time (e.g., 09/16/98 23:48:10)
%d	day of the month (16) [01-31]
%H	hour, using a 24-hour clock (23) [00-23]
%I	hour, using a 12-hour clock (11) [01-12]
%M	minute (48) [00-59]
%m	month (09) [01-12]
%p	either "am" or "pm" (pm)
%S	second (10) [00-61]
%w	weekday (3) [0-6 = Sunday-Saturday]
%x	date (e.g., 09/16/98)
%X	time (e.g., 23:48:10)
%Y	full year (1998)
%y	two-digit year (98) [00-99]
%%	the character `%´
--]]
