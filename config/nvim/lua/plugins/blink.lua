return {
  "saghen/blink.cmp",

  opts = {
    completion = {
      list = {
        selection = {
          -- Do not preselect first completion item to allow pressing <CR> without
          -- accepting the first suggestion. Use <C-y> to select and accept the first
          -- suggestion or <C-n> to select the first suggestion and then pressing
          -- <CR> to accept it.
          preselect = false,
        },
      },
    },
    keymap = {
      preset = "enter",
      ["<C-y>"] = { "select_and_accept" },
    },
  },
}
