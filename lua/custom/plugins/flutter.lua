return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,  -- Esto indica que el plugin se carga inmediatamente
  dependencies = {
    'nvim-lua/plenary.nvim',  -- Necesario para las utilidades
    'stevearc/dressing.nvim', -- Opcional, pero recomendado si usas vim.ui.select
  },
  opts = true,  -- Otras opciones que pudieras configurar para el plugin

  config = function()
    local M = {}
    local commands = require("flutter-tools.commands")
    local ui = require("flutter-tools.ui")
    local devices = require("flutter-tools.devices")

    -- Lista de comandos de Flutter
    function M.get_flutter_commands()
      return {
        -- Comandos básicos de Flutter
        { label = "Flutter Run", command = commands.run },
        { label = "Flutter Debug", command = commands.debug },
        { label = "Flutter Reload", command = commands.reload },
        { label = "Flutter Restart", command = commands.restart },
        { label = "Flutter Quit", command = commands.quit },
        { label = "Flutter Attach", command = commands.attach },
        { label = "Flutter Detach", command = commands.detach },
        { label = "Flutter Outline Toggle", command = commands.toggle_outline },
        { label = "Flutter Outline Open", command = commands.open_outline },
        { label = "Flutter DevTools", command = commands.dev_tools },
        { label = "Flutter DevTools Activate", command = commands.activate_dev_tools },
        { label = "Flutter Copy Profiler Url", command = commands.copy_profiler_url },
        { label = "Flutter LSP Restart", command = commands.lsp_restart },
        { label = "Flutter Super", command = commands.super },
        { label = "Flutter Reanalyze", command = commands.reanalyze },
        { label = "Flutter Rename", command = commands.rename },
        { label = "Flutter Log Clear", command = commands.log_clear },
        { label = "Flutter Log Toggle", command = commands.log_toggle },

        -- Comandos de dispositivos
        { label = "Flutter Devices", command = devices.list_devices },
        { label = "Flutter Emulators", command = devices.list_emulators },
      }
    end

    -- Función para mostrar el selector de comandos
    function M.select_flutter_command()
      local cmds = M.get_flutter_commands()

      -- Usamos vim.ui.select para mostrar la lista de comandos de Flutter
      vim.ui.select(cmds, {
        prompt = "Selecciona un comando Flutter:",
        format_item = function(item)
          return item.label  -- Mostramos solo el nombre del comando
        end,
      }, function(selected_command)
        if selected_command then
          -- Ejecutar el comando seleccionado
          local success, msg = pcall(selected_command.command)
          if not success then
            vim.notify(msg, vim.log.levels.ERROR)
          end
        else
          vim.notify("No se seleccionó ningún comando.", vim.log.levels.WARN)
        end
      end)
    end

    -- Mapear la tecla para abrir el selector
    vim.keymap.set({ "n" }, "<leader>mm", function()
      M.select_flutter_command()
    end, { desc = "Seleccionar y ejecutar un comando Flutter" })

    -- Aquí puedes agregar otros comandos o configuraciones adicionales para Flutter

    return M
  end
}

