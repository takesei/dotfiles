---------------------------------------------------------------------------
-- autoload functions
---------------------------------------------------------------------------
function Toggle_option(option_name)
  if option_name == 'laststatus' then
    if vim.opt_local.laststatus:get() == 0 then
      vim.opt_local.laststatus = 2
    else
      vim.opt_local.laststatus = 0
    end
  else
    -- vim.opt_local[option_name] = (1 - vim.opt[option_name]:get())
    vim.opt_local[option_name] = not vim.opt_local[option_name]:get()
  end

  vim.notify(option_name .. ': ' .. tostring(vim.opt_local[option_name]:get()), "info", {timeout=10})
end

--[[



function vimrc#append_diff() abort
  " Get the Git repository root directory
  let git_root = '.git'->finddir('.;')->fnamemodify(':h')

  " Get the diff of the staged changes relative to the Git repository root
  let diff = ('git -C ' .. git_root .. ' diff --cached')->system()

  " Add a comment character to each line of the diff
  let comment_diff = diff->split('\n')[: 200]
        \ ->map({ -> '# '.. v:val })

  " Append the diff to the commit message
  call append('$'->line(), comment_diff)
endfunction
]]
