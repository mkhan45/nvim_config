local api = vim.api

local M = {}

local term_win = 0 
local term_buf = 0 

function M.term_toggle()
   if (api.nvim_get_current_win() == term_win) then
      api.nvim_command("hide")
   elseif (api.nvim_win_get_option(term_win, 'active') == true) then
      api.nvim_set_current_win(term_win)
   else
      local width, height = 90, 15
      local term_width = api.nvim_get_option('columns')
      local term_height = api.nvim_get_option('lines')

      local opts = {
         relative = 'editor',
         width = width,
         height = height,
         row = math.floor((term_height - height) / 2),
         col = math.floor((term_width - width) / 2),
      }

      if (term_buf == 0) or (not (api.nvim_buf_is_loaded(term_buf))) then
         term_buf = api.nvim_create_buf(true, false)
         api.nvim_open_win(term_buf, true, opts)
         api.nvim_command("term")
      else
         api.nvim_open_win(term_buf, true, opts)
      end

      term_win = api.nvim_get_current_win()
   end
end

function M.term_run(cmd)
   if (api.nvim_get_current_win() == term_win) then
      -- api.nvim_feedkeys("a\\<CR>\\<ESC>", 'm', false)
      api.nvim_put({cmd}, "", true, true)
      api.nvim_command('call feedkeys("a\\<CR>\\<ESC>")')
   end
end

return M
