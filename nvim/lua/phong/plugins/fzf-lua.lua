return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional for icon support
  opts = function()
    local config = require("fzf-lua.config")
    local actions = require("fzf-lua.actions")

    -- Key mappings for fzf
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

    -- Image previewer setup
    local img_previewer
    for _, v in ipairs({
      { cmd = "ueberzug", args = {} },
      { cmd = "chafa", args = { "{file}", "--format=symbols" } },
      { cmd = "viu", args = { "-b" } },
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    return {
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      defaults = {
        formatter = "path.dirname_first",
      },
      previewers = {
        builtin = {
          extensions = {
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "fit_contain",
        },
      },
      files = {
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return "TroubleIcon" .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. "\t"
          end,
        },
      },
    }
  end,
  config = function(_, opts)
    require("fzf-lua").setup(opts)
  end,
  keys = {
    -- find
    { "<leader><space>", function() require("fzf-lua").files({ cwd = "$HOME" }) end, desc = "Find Files(ROOT)" },
    { "<leader><backspace>", function() require("fzf-lua").files({ cwd = vim.fn.expand('%:p:h') }) end, desc = "Find Files(Buffer Dir)" },
    { "<leader>/", function() require("fzf-lua").live_grep({ cwd = vim.fn.expand('%:p:h') }) end, desc = "Live Grep (CWD)" },
    { "<leader>;", function() require("fzf-lua").live_grep({ cwd = "$HOME" }) end, desc = "Live Grep (ROOT)"},
    { "<leader>,", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
    { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },
    -- git
    { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Git Commits" },
    { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Git Status" },
    -- search
    { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
    { "<leader>sf", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search Word" },
    { "<leader>sF", "<cmd>FzfLua grep_cword<cr>", desc = "Search Current Word" },
    { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
  }
}
