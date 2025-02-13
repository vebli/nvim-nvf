{pkgs, lib, ...}:
{
  vim = {
    luaConfigRC.myconfig = /*lua*/ ''
--- OPTIONS ---

local opt = vim.opt
local g = vim.g

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloats", { bg = "none" })

opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true
-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2
vim.cmd('filetype plugin indent on')
vim.o.autoindent = true

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false
vim.wo.relativenumber = true

-- Folding
local vim = vim
local opt = vim.opt
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 99
--open folds by default
vim.cmd([[ set nofoldenable]])

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"


-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

--- KEYMAPS ---
vim.g.mapleader = " "
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true}
local function nmap(key, map)
  keymap('n', key, map, opts)
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
nmap('<leader>ti', ':Trouble diagnostics toggle pinned=true win.relative=win win.position=bottom<CR>')
nmap('<leader>ts', ':Trouble symbols toggle pinned=true win.relative=win win.position=right<CR>')
    '';
    spellcheck = {
      enable = true;
      languages = ["en" "de"];
    };
    theme = {
      enable = true;
      name = "rose-pine";
      style = "main";
    };
    statusline.lualine.enable  = true;
    autocomplete.nvim-cmp.enable = true;
    autopairs.nvim-autopairs.enable = true;
    
    languages = {
      enableLSP = true;
      enableTreesitter = true;

      assembly.enable  = true;
      bash.enable = true;
      clang.enable = true;
      nix = {
        enable = true;
        lsp.server = "nixd";
      };
      odin.enable = true;
      ts.enable = true;
      lua.enable = true;
      python.enable = true;
      css.enable = true;
      go.enable = true;
      haskell.enable = true;
      html.enable = true;
      java.enable = true;
      ocaml.enable = true;
      php.enable = true;
      r.enable = true;
      ruby.enable = true;
      scala.enable = true;
      sql.enable = true;
      tailwind.enable = true;
      zig.enable = true;


    };

    lazy.plugins = with pkgs.vimPlugins; {
      "alpha-nvim" = {
        package = alpha-nvim;
        lazy = false;
        after = ''
          local status_ok, alpha = pcall(require, "alpha")
          if not status_ok then
            return
              end

              local dashboard = require("alpha.themes.dashboard")
              dashboard.section.header.val = {

                [[          ▀████▀▄▄              ▄█ ]],
                [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
                [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
                [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
                [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
                [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
                [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
                [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
                [[   █   █  █      ▄▄           ▄▀   ]],

              }

        dashboard.section.buttons.val = {
          dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
          dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
          dashboard.button("r", "󰙰  Recently used files", ":Telescope oldfiles <CR>"),
          dashboard.button("t", "󱘢  Find text", ":Telescope live_grep <CR>"),
          dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.vim<CR>"),
          dashboard.button("q", "󰈆  Quit Neovim", ":qa<CR>"),
        }

        local function footer()
          return "Write code, not excuses"
          end

          dashboard.section.footer.val = footer()

          dashboard.section.footer.opts.hl = "Type"
          dashboard.section.header.opts.hl = "Include"
          dashboard.section.buttons.opts.hl = "Keyword"

          dashboard.opts.opts.noautocmd = true
          alpha.setup(dashboard.opts)


          '';
      };
      "vimtex" = {
        package = vimtex;
        lazy = false;
      };
      "godbolt.nvim" = {
        package = godbolt-nvim;
        cmd = "GodBolt";
        after = ''
          require'godbolt'.setup()
          '';
      };
      "nvim-highlight-colors" = {
        package = nvim-highlight-colors;
        event =  ["BufReadPost" "BufNewFile"];
      };
      "oil.nvim" = {
        package = oil-nvim;
        cmd = "Oil";
        after = ''
        require'oil'.setup()
        '';
      };
      "otter.nvim" = {
        package = otter-nvim;
        cmd = "Otter";
        after = ''
          require'otter'.activate()
        '';
      };
      "overseer.nvim" = {
        package = overseer-nvim;
        after = ''
          require("overseer").setup({
              strategy = "toggleterm"
          })
        '';
      };
      "lsp_signature.nvim" = {
        package = lsp_signature-nvim;
        event =  ["BufReadPost" "BufNewFile"];
        after = ''
          require"lsp_signature".setup({
              border = 'none',
              hint_enable = false,
            })
        '';
      };
      "telescope.nvim" = {
        package = telescope-nvim;
        cmd = "Telescope";
        after = ''
          require('telescope').setup{
            defaults = {
              file_ignore_patterns = {"build", "node_modules"}
            }
          }
        '';
      };
      "tmux.nvim" = {
        package = tmux-nvim;
        lazy = false;
      };
      "toggleterm.nvim" = {
        package = toggleterm-nvim;
        cmd = "ToggleTerm";
        after = ''
          require'toggleterm'.setup{
            start_in_insert = true,
            size = 5,
          }
        '';
      };
      "trouble.nvim" = {
        package = trouble-nvim;
        cmd = "Trouble";
        after = ''
          require'trouble'.setup()
        '';
      };
      "cmake-tools.nvim" = {
        package = cmake-tools-nvim;
        ft = ["c" "cpp" "h" "hpp"];
        after = /*lua*/''
        require'cmake-tools'.setup{ 
          cmake_dap_configuration = { -- debug settings for cmake
            name = "cpp",
            type = "gdb",
            request = "launch",
            stopOnEntry = false,
            runInTerminal = true,
            console = "integratedTerminal",
          },
          toggleterm = {
            direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
            close_on_exit = false, -- whether close the terminal when exit
            auto_scroll = true, -- whether auto scroll to the bottom
          },
          overseer = {
            new_task_opts = {
                strategy = {
                    "toggleterm",
                    direction = "horizontal",
                    autos_croll = true,
                    quit_on_exit = "success"
                }
            }, -- options to pass into the `overseer.new_task` command
            on_new_task = function(task)
            end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
          },
        }
        '';
      };
    };
  };

  
}
