-- This module should contain all of the options for the theme that I am currently using.

return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
            require("kanagawa").setup({
                overrides = function()
                    return {
                        LineNr = { bg = "NONE" },
                        CursorLineNr = { bg = "NONE" },
                        SignColumn = { bg = "NONE" },
                        FoldColumn = { bg = "NONE" },
                    }
                end
            })

			vim.cmd.colorscheme("kanagawa-dragon")
		end,
	},
}
