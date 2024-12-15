return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- or another event of your choice
  config = function()
    require("persistence").setup({
      dir = vim.fn.stdpath("state") .. "/sessions/", -- default session directory
      options = { "buffers", "curdir", "tabpages", "winsize" },
    })

    local keymap = vim.keymap.set

    -- Don't save the current session
    keymap("n", "<leader>qd", function()
      require("persistence").stop()
    end, { desc = "Don't Save Current Session" })

    -- Restore the last session for the current working directory
    keymap("n", "<leader>ql", function()
      require("persistence").load({ last = true })
    end, { desc = "Restore Last Session" })

    -- Restore session for the current working directory (if exists)
    keymap("n", "<leader>qs", function()
      require("persistence").load()
    end, { desc = "Restore Session" })

    -- Select Session
    -- NOTE: persistence.nvim by itself doesn't provide a built-in session browser.
    -- If you want a session selection UI, integrate with a tool like telescope or manually switch directories.
    -- For now, this is just mapped to load, which restores the session for the current directory.
    keymap("n", "<leader>qS", function()
      -- Placeholder: if you integrate telescope or another tool to select sessions, call it here.
      require("persistence").load()
    end, { desc = "Select Session" })
  end,
}

