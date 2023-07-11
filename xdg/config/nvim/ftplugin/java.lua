-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

-- nvim data and config path (:h stdpath)
local nvim_data_path = vim.fn.stdpath('data') .. '/'
-- location where mason installs jdts
local mason_package_path = nvim_data_path .. 'mason/packages/'
local jdtls_path = mason_package_path .. 'jdtls/'
-- root project dir of currently opened file
local project_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
-- last part of the project_dir
local project_name = vim.fn.fnamemodify(project_dir, ':p:h:t')

local jdtls = require('jdtls')
local whichkey = require('which-key')

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    '/home/mike/.sdkman/candidates/java/17.0.6-tem/bin/java',

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-javaagent:' .. jdtls_path .. 'lombok.jar',
    '-jar',  vim.fn.glob(jdtls_path .. 'plugins/org.eclipse.equinox.launcher_*.jar', 1),
    '-configuration', (jdtls_path .. 'config_linux'),

    -- directory where jdtls stores project related data
    '-data', (nvim_data_path .. 'jdtls_data/' .. project_name),
  },

  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = project_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      autobuild = { enabled = false },
      codeGeneration = {
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
      },
      contentProvider = {
        preferred = 'fernflower'
      },
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
    },
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  init_options = {
  },

  on_attach = function(client, bufnr)

    jdtls.setup.add_commands()

    whichkey.register({
      ['<A-o>'] = { jdtls.organize_imports, 'Java: Organize imports'},
      ['<leader>se']= { vim.lsp.buf.format, 'Format code'},
    })
  end
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
