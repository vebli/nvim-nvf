{pkgs, inputs, lib, ...}:
let 
  lua_dir = import ./rtp.nix {inherit pkgs;};
  lua_files = "${lua_dir}/lua";
  keymaps = builtins.readFile "${lua_files}/keymaps.lua";
  options = builtins.readFile "${lua_files}/options.lua";
  lua_plugin_dir = "${lua_files}/plugins";
  snippets_dir = "${lua_files}/snippets";
  insert_plugin_config = (name: 
    (builtins.readFile "${lua_plugin_dir}/${name}.lua")
  );
in 
  {
  vim = {
    luaConfigRC.myconfig = ''
      ${options}
      ${keymaps}
    '';
    extraPackages = with pkgs; [
      texlivePackages.latexmk
      texliveFull
    ];
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
    snippets.luasnip = {
      enable = true;
      loaders = 
        # require("luasnip.loaders.from_lua").lazy_load({paths = "${snippets_dir}"})
        ''
        require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/lua/snippets"})
        '';
      setupOpts.enable_autosnippets = true;
    };

    autocomplete.nvim-cmp = {
      enable = true;
      sourcePlugins = ["luasnip"];
      setupOpts = {
        sourcePlugins = ["vim-dadbod-completion"];
      };
      mappings = {
        confirm = "<Tab>";
        next = "<C-n>";
        previous = "<C-p>";
      };
    };
    autopairs.nvim-autopairs.enable = true;
    useSystemClipboard = true;

    visuals = {
      nvim-web-devicons.enable = true;
      rainbow-delimiters.enable = true;
    };

    ui.borders.enable = true;

    lsp = {
      enable = true;
      lightbulb.enable = true;
      lspconfig = {
        enable = true;
        sources = {
          texlab = ''
          lspconfig.texlab.setup{
            capabilities = capabilities;
          }
          '';
        };
      };
      lspkind.enable = true;
    };

    debugger.nvim-dap = {
      enable = true;
      # sources = ["gdb"];
      ui.enable = true;
    };
    languages = {
      enableLSP = true;
      enableTreesitter = true;
      enableFormat = true;
      enableDAP = true;

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

    extraPlugins = with pkgs.vimPlugins; {
      "vimtex" = {
        package = vimtex;
        setup = insert_plugin_config "vimtex";
      };
    };
    lazy.plugins = with pkgs.vimPlugins; {
      "alpha-nvim" = {
        package = alpha-nvim;
        lazy = false;
        after = insert_plugin_config "alpha";
      };
      "godbolt.nvim" = {
        package = godbolt-nvim;
        cmd = ["GodBolt"];
        after = insert_plugin_config "godbolt";
      };
      "nvim-highlight-colors" = {
        package = nvim-highlight-colors;
        event =  ["BufReadPost" "BufNewFile"];
      };
      "oil.nvim" = {
        package = oil-nvim;
        cmd = ["Oil"];
        after = insert_plugin_config "oil";
      };
      "otter.nvim" = {
        package = otter-nvim;
        cmd = ["Otter"];
        after = insert_plugin_config "otter";
      };
      "overseer.nvim" = {
        package = overseer-nvim;
        after = insert_plugin_config "overseer";
      };
      "lsp_signature.nvim" = {
        package = lsp_signature-nvim;
        event =  ["BufReadPost" "BufNewFile"];
        after = insert_plugin_config "signature";
      };
      "luasnip" = {
        after = insert_plugin_config "luasnip";
      };
      "telescope.nvim" = {
        package = telescope-nvim;
        cmd = ["Telescope"];
        after = insert_plugin_config "telescope";
      };
      "tmux.nvim" = {
        package = tmux-nvim;
        lazy = false;
        after = insert_plugin_config "tmux-nvim";
      };
      "toggleterm.nvim" = {
        package = toggleterm-nvim;
        cmd = ["ToggleTerm"];
        after = insert_plugin_config "toggle-term";
      };
      "trouble.nvim" = {
        package = trouble-nvim;
        cmd = ["Trouble"];
        after = insert_plugin_config "trouble";
      };
      "vim-dadbod" = {
        package = vim-dadbod;
      };
      "vim-dadbod-ui" = {
        package = vim-dadbod-ui;
        cmd = [ "DBUI" "DBUIToggle" "DBUIAddConnection" "DBUIFindBuffer" ];
        before = ''
          vim.g.db_ui_use_nerd_fonts = 1
        '';
      };
      "vim-dadbod-completion" = {
        package = vim-dadbod-completion; 
      };

      "cmake-tools.nvim" = {
        package = cmake-tools-nvim;
        ft = ["c" "cpp" "h" "hpp" "txt"];
        after = insert_plugin_config "cmake-tools";
      };
    };
  };
}
