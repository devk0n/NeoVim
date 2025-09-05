return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      -- Auto open/close dap-ui
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Adapter: GDB
      dap.adapters.gdb = {
        type = "executable",
        command =
        "/home/devkon/.espressif/tools/xtensa-esp-elf-gdb/16.2_20250324/xtensa-esp-elf-gdb/bin/xtensa-esp32s3-elf-gdb",
        args = { "--interpreter=mi2" },
      }

      -- Config: attach to OpenOCD
      dap.configurations.c = {
        {
          name = "Attach to ESP32-S3",
          type = "gdb",
          request = "launch",
          program = "${workspaceFolder}/build/blink.elf",
          cwd = "${workspaceFolder}",
          target = "localhost:3333",
        },
      }
      dap.configurations.cpp = dap.configurations.c

      -- Basic debugging
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue/Start" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })

      -- Breakpoints
      vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<Leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Set Conditional Breakpoint" })
      vim.keymap.set("n", "<Leader>lp", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { desc = "Set Logpoint" })

      -- REPL & eval
      vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open DAP REPL" })
      vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last Debug Session" })
      vim.keymap.set({ "n", "v" }, "<Leader>de", function()
        dapui.eval()
      end, { desc = "Evaluate expression" })

      -- DAP UI control
      vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
      vim.keymap.set("n", "<Leader>dx", dap.terminate, { desc = "Terminate Debug Session" })
    end,
  },
}
