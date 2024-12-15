-- File: lua/plugins/lazygit.lua

-- Define the helper function to open LazyGit in the root directory
local function open_lazygit_root()
  -- Fetch the root directory of the git repository
  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if root and root ~= "" then
    -- Change Neovim's working directory to the git root
    vim.cmd("cd " .. root)
    -- Open LazyGit
    vim.cmd("LazyGit")
  else
    vim.notify("Git repository root not found", vim.log.levels.ERROR)
  end
end

return {
  "kdheepak/lazygit.nvim",
  -- Lazy-load the plugin when any of these commands are called
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  keys = {
    -- Open LazyGit in the root directory
    {
      "<leader>gg",
      open_lazygit_root,    -- Reference the helper function
      desc = "Lazygit (Root Dir)",
      mode = "n",
    },
    -- Open LazyGit in the current working directory
    {
      "<leader>gG",
      "<cmd>LazyGit<CR>",
      desc = "Lazygit (cwd)",
      mode = "n",
    },
    -- Open LazyGit for the current file's history
    {
      "<leader>gf",
      "<cmd>LazyGitCurrentFile<CR>",
      desc = "Lazygit Current File History",
      mode = "n",
    },
    -- Open LazyGit log in the root directory
    {
      "<leader>gl",
      "<cmd>LazyGitFilter<CR>",
      desc = "Lazygit Log (Root Dir)",
      mode = "n",
    },
    -- Open LazyGit log in the current working directory
    {
      "<leader>gL",
      "<cmd>LazyGitFilterCurrentFile<CR>",
      desc = "Lazygit Log (cwd)",
      mode = "n",
    },
    -- Git blame for the current line
    {
      "<leader>gb",
      "<cmd>GitBlameToggle<CR>",
      desc = "Git Blame Line",
      mode = "n",
    },
    -- Git browse (open) in normal and visual modes
    {
      "<leader>gB",
      "<cmd>GitBrowse<CR>",
      desc = "Git Browse (open)",
      mode = { "n", "x" },
    },
    -- Git browse (copy URL) in normal and visual modes
    {
      "<leader>gY",
      "<cmd>GitBrowseCopy<CR>",
      desc = "Git Browse (copy)",
      mode = { "n", "x" },
    },
  },
  config = function()
    require('lazygit').setup {
      -- Your LazyGit configuration options (if any)
    }
  end,
}



