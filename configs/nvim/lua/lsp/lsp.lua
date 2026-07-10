return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- Auto-show diagnostic float on cursor hold (like coc.nvim)
        vim.o.updatetime = 300
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
                vim.diagnostic.open_float(nil, {
                    focusable = false,
                    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                    border = "rounded",
                    source = "always",
                    prefix = " ",
                    scope = "cursor",
                })
            end,
        })

        -- Keymaps set only when LSP attaches to a buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspKeys", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

				-- Hover docs. Cursor on printf → press K → float shows its signature and description.
                map("K",          vim.lsp.buf.hover,           "Hover Documentation")
				-- Go to definition. Cursor on a function call foo() → gd → jumps to where foo is defined.
                map("gd",         vim.lsp.buf.definition,      "Go to Definition")
				-- Go to definition. Cursor on a function call foo() → gd → jumps to where foo is defined.
                map("gD",         vim.lsp.buf.declaration,     "Go to Declaration")
				-- Go to implementation. Cursor on an interface/abstract method → gi → jumps to the actual implementation.
                map("gi",         vim.lsp.buf.implementation,  "Go to Implementation")
				-- Go to references. Cursor on a variable x → gr → shows every place x is used in the project.
                map("gr",         vim.lsp.buf.references,      "Go to References")
				-- Rename. Cursor on variable foo → <leader>rn → type new name → renames every occurrence across all files.
                map("<leader>rn", vim.lsp.buf.rename,          "Rename Symbol")
				-- Code action. Cursor on an underlined error → <leader>ca → clangd suggests fixes like "add missing include" or "add cast".
                map("<leader>ca", vim.lsp.buf.code_action,     "Code Action")
				-- Type definition. Cursor on a variable node of type Node* → <leader>D → jumps to where Node struct is defined.
                map("<leader>D",  vim.lsp.buf.type_definition, "Type Definition")

                -- Diagnostics
				--[d / ]d — Previous/next diagnostic. Jumps your cursor between errors and warnings in the file.
                map("[d",        vim.diagnostic.goto_prev,   "Previous Diagnostic")
                map("]d",        vim.diagnostic.goto_next,   "Next Diagnostic")
				-- Puts all diagnostics in the quickfix list so you can cycle through every error in the project with :cn / :cp
                map("<leader>q", vim.diagnostic.setloclist,  "Diagnostic List")
            end,
        })

        vim.diagnostic.config({
            virtual_text = false,   -- disabled since the float shows it
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

		require("lsp.servers.lua_ls")
		require("lsp.servers.bash_ls")
		require("lsp.servers.c")
		require("lsp.servers.html")
		require("lsp.servers.cssls")
		require("lsp.servers.jsonls")
		require("lsp.servers.nix")
		require("lsp.servers.pyright")

		vim.lsp.handlers["$/progress"] = function() end
    end,
}
