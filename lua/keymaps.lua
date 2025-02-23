vim.g.mapleader = " "
local opts = {noremap = true}
local function nmap(key, map, desc)
  if desc then
    opts.desc = desc
  end
  vim.keymap.set('n', key, map, opts)
end

local function toggle_virtual_text()
  if vim.diagnostic.config().virtual_text == true then
    vim.diagnostic.config({virtual_text = false})
  else
    vim.diagnostic.config({virtual_text = true})
  end
end

--- Built-in ---
nmap('<leader>bn', ':bnext<CR>')
nmap('<leader>bp', ':bprevious<CR>')
nmap('<leader>nh', ':noh<CR>')

--- Telescope ---
nmap('<leader>ff', ':Telescope find_files<CR>')
nmap('<leader>fg', ':Telescope git_files<CR>')
nmap('<leader>bm', ':Telescope buffers<CR>')
nmap('<leader>qf', ':Telescope quickfix<CR>')



--- LSP ---
nmap('<leader>fc', ':ClangdSwitchSourceHeader')
nmap('gd' ,':lua vim.lsp.buf.definition()<cr>')
nmap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')
nmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
nmap("<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>")
nmap("<leader>vo", toggle_virtual_text)

--- CMake Tools ---
nmap('<leader>cm', ':CMakeRun<CR>')

--- DAP (Debugger) ---
nmap('<leader>di', ':CMakeDebug<CR>')
nmap('<leader>db', ':lua require("dap").toggle_breakpoint()<CR>')
nmap('<leader>dc', ':lua require("dap").continue()<CR>')
nmap('<leader>ds', ':lua require("dap").step_over()<CR>')

--- DB ---
nmap('<leader>dad', ':DBUIToggle<CR>')

-- Oil
nmap('-', '<CMD>Oil<CR>')

-- Trouble 
nmap('<leader>tt', ':ToggleTerm<CR>')
nmap('<leader>ti', ':Trouble diagnostics toggle pinned=true win.relative=win win.position=bottom<CR><CR>')
nmap('<leader>ts', ':Trouble symbols toggle pinned=true win.relative=win win.position=right<CR>')
