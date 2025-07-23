# jq.nvim 🚀

An interactive `jq` runner for Neovim. 🎈

This plugin allows you to run `jq` queries on your JSON content directly within Neovim, providing an interactive experience with a command buffer and an output buffer that updates as you type.

## ✨ Features

*   Run `jq` filters on the current file.
*   Run `jq` filters on a visual selection.
*   Interactive command window to enter your `jq` query.
*   Real-time output buffer that updates on execution.

## ✅ Requirements

*   `jq` installed and available in your `PATH`.

## 📦 Installation

### lazy.nvim

```lua
{
  'JamiroFerrara/jq.nvim',
  event = 'VeryLazy',
  config = function()
    require('jq').setup()
  end
}
```

## 🚀 Usage

The plugin provides two main commands:

*   `:JqFile`: Opens the interactive `jq` runner for the entire content of the current buffer.
*   `:JqVisual`: Opens the interactive `jq` runner for the visually selected text.

When you run either of these commands, two new windows will open:
1.  A small command buffer at the top where you can type your `jq` filter.
2.  A larger output buffer below that displays the result of the `jq` query.

Simply type your `jq` filter in the command buffer and press `<CR>` to see the output update in real-time.

To close the `jq` windows, simply close the command buffer window. 👋

## ⌨️ Example Keybindings

You can map the commands to keybindings for easier access. For example:

```lua
-- In your init.lua or a relevant keymap file
vim.keymap.set("v", "<leader>jq", "<cmd>JqVisual<cr>", { desc = "jq on visual selection" })
vim.keymap.set("n", "<leader>jq", "<cmd>JqFile<cr>", { desc = "jq on current file" })
```
