local M = {}

local _, actions = pcall(require, "telescope.actions")

local function get_pickers()
  return {
    find_files = {
      theme = "ivy",
      hidden = true,
      --[[ previewer = true, ]]
    },
    live_grep = {
      --@usage don't include the filename in the search results
      only_sort_text = true,
      theme = "ivy",
    },
    grep_string = {
      only_sort_text = true,
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
      previewer = false,
      initial_mode = "normal",
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },
    planets = {
      show_pluto = true,
      show_moon = true,
    },
    git_files = {
      theme = "ivy",
      hidden = true,
      previewer = false,
      show_untracked = true,
    },
    lsp_references = {
      theme = "dropdown",
      initial_mode = "normal",
    },
    lsp_definitions = {
      theme = "dropdown",
      initial_mode = "normal",
    },
    lsp_declarations = {
      theme = "ivy",
      initial_mode = "normal",
    },
    lsp_implementations = {
      theme = "ivy",
      initial_mode = "normal",
    },
  }
end

function M.pickers()
  return get_pickers()
end

return M
