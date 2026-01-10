-- Customize ALE

---@type LazySpec
return {
  'dense-analysis/ale',
  config = function()
      -- Configuration goes here.
      local g = vim.g

      g.ale_ruby_rubocop_auto_correct_all = 1

      g.ale_linters = {
          ruby = {'rubocop', 'ruby'},
          lua = {'lua_language_server'}
      }
      g.ale_fix_on_save = 1
      g.ale_fixers = {
        javascript = {'prettier'},
        typescript = {'prettier'},
        css = {'prettier'},
        scss = {'prettier'},
        json = {'prettier'},
        graphql = {'prettier'},
        markdown = {'prettier'},
        vue = {'prettier'},
        yaml = {'prettier'},
        html = {'prettier'},
        javascriptreact = {'prettier', 'eslint'},
        typescriptreact = {'prettier', 'eslint'},
        _ = {'prettier'},
      }
  end
}
