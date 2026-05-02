-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local homebrew_gcc = "/opt/homebrew/opt/gcc"
local gcc_cxx_versions = vim.fn.glob(homebrew_gcc .. "/include/c++/*", false, true)
table.sort(gcc_cxx_versions)
local gcc_cxx_include = gcc_cxx_versions[#gcc_cxx_versions] or (homebrew_gcc .. "/include/c++/15")

local gcc_target_includes = vim.fn.glob(gcc_cxx_include .. "/*-apple-darwin*", false, true)
table.sort(gcc_target_includes)
local gcc_target_include = gcc_target_includes[#gcc_target_includes] or (gcc_cxx_include .. "/aarch64-apple-darwin24")

local gcc_query_drivers = {}
for _, pattern in ipairs {
  homebrew_gcc .. "/bin/gcc-[0-9]*",
  homebrew_gcc .. "/bin/g++-[0-9]*",
  "/opt/homebrew/bin/gcc-[0-9]*",
  "/opt/homebrew/bin/g++-[0-9]*",
} do
  vim.list_extend(gcc_query_drivers, vim.fn.glob(pattern, false, true))
end

local macos_sdk = vim.fn.systemlist { "xcrun", "--show-sdk-path" }[1]
if vim.v.shell_error ~= 0 or macos_sdk == "" then macos_sdk = "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk" end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Clear deprecated vim.lsp.with() handlers from AstroNvim defaults
    lsp_handlers = {},
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "c",
          "cpp",
          "rust",
          "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      clangd = {
        cmd = {
          "/opt/homebrew/opt/llvm/bin/clangd",
          "--fallback-style=LLVM",
          "--query-driver=" .. table.concat(gcc_query_drivers, ","),
        },
        init_options = {
          fallbackFlags = {
            "-xc++",
            "-std=gnu++23",
            "-nostdinc++",
            "-isystem",
            gcc_cxx_include,
            "-isystem",
            gcc_target_include,
            "-isystem",
            gcc_cxx_include .. "/backward",
            "-isysroot",
            macos_sdk,
          },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
