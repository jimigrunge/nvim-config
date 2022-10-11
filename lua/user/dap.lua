local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  print 'Dap not loaded'
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  print 'DapUI not loaded'
	return
end

local dap_python_status_ok, dappython = pcall(require, "dap-python")
if dap_python_status_ok then
  dappython.setup('~/.virtualenvs/debugpy/bin/python')
end


-- Setup the DAP adapters
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = {os.getenv("HOME") .. '/.local/share/debug-adapters/vscode-php-debug/out/phpDebug.js'}
}
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.local/share/debug-adapters/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/.local/share/debug-adapters/vscode-chrome-debug/out/src/chromeDebug.js"}
}

-- Set up DAP configurations
dap.configurations.typescript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}
dap.configurations.javascriptreact = { -- change this to javascript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}
dap.configurations.typescriptreact = { -- change to typescript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}
dap.configurations.php = {
  {
    name = 'Listen for Xdebug',
    type = 'php',
    request = 'launch',
    port = 9000
  },{
    name = 'run current script',
    type = 'php',
    request = 'launch',
    port = 9000,
    cwd = vim.fn.getcwd(),
    program = "${file}",
    runtimeExacutable = 'php'
  }
}

-- Setup the DAP user interface
dapui.setup {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- You can change the order of elements in the sidebar
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 }, -- Can be float or integer > 1
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}

vim.fn.sign_define('DapBreakpoint', {text="", texthl='DiagnosticSignError', linehl='', numhl=''})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
