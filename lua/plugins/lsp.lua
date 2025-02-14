      local cmp = require('cmp')

          cmp.setup({
                  snippet = {
                  -- REQUIRED - you must specify a snippet engine
                  expand = function(args)
                  require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                  end,
                  },
                  mapping = cmp.mapping.preset.insert({
                          ['<C-k>'] = cmp.mapping.select_prev_item(),
                          ['<C-j>'] = cmp.mapping.select_next_item(),
                          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                          ['<C-f>'] = cmp.mapping.scroll_docs(4),
                          ['<C-Space>'] = cmp.mapping.complete(),
                          ['<C-e>'] = cmp.mapping.abort(),
                          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                          }),
                  sources = cmp.config.sources({
                          { name = 'nvim_lsp' },
                          { name = 'luasnip' },
                          { name = 'vim-dadbod-completion'},
                          }, {
                          { name = 'buffer' },
                          })
          })

      --lspconfig setup

          mapping = cmp.mapping.preset.insert({
                  ['<C-Space>'] = cmp.mapping.complete(),
                  ['<C-e>'] = cmp.mapping.abort(),
                  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                  })
          local lspconfig = require('lspconfig')
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          local servers = {
              'texlab',
              'lua_ls',
              'pylsp',
              'gopls',
              'nil_ls',
              'html',
              'biome',
              'cssls',
              'tailwindcss',
              'cmake',
              'docker_compose_language_service',
              'dockerls',
              'rust_analyzer',
              'arduino_language_server',
              'asm_lsp',
              'ols'
          }
      for _, server in ipairs(servers) do
          lspconfig[server].setup {
              capabilities = capabilities,
          }
      end

      lspconfig.clangd.setup {
          capabilities = capabilities,
                       cmd = { 'clangd', '--compile-commands-dir=build'},
                       filetypes = { 'c', 'cpp' },
                       root_dir = function() return vim.fn.getcwd() end,
                       on_attach = function(client, bufnr)
                           -- Set compiler flags
                           vim.api.nvim_buf_set_option(bufnr, 'makeprg', 'clang\\ -Wall\\ -Wextra\\ -O3\\ %')
                           vim.api.nvim_buf_set_option(bufnr, 'errorformat', '%f:%l:%c:\\ %tarning:\\ %m,%f:%l:%c:\\ %trror:\\ %m')
                           end,
      }
      lspconfig.sqls.setup {
          capabilities = capabilities,
                       root_dir = function() return vim.fn.getcwd() end,
      }
      lspconfig.nixd.setup {
          cmd = {"nixd"},
          settings = {
              nixd = {
                  nixpkgs = {
                      expr = "import <nixpkgs> { }",
                  },
                  formatting = {
                      command = {"alejandra"},
                  },
              },
          },
      }
