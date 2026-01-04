return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    -- Optional: make it feel more like VS Code
    vim.g.VM_default_mappings = 0
    vim.g.VM_maps = {
      ["Find Under"]         = "<C-d>", -- VS Code Ctrl+D
      ["Find Subword Under"] = "<C-d>",
      ["Select All"]         = "<C-A-d>",
      ["Skip Region"]        = "<C-x>",
      ["Remove Region"]      = "<C-p>",
    }
  end,
}

