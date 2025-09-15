# Agent instructions

## Overview

This repository contains my LazyVIm configuration.

## Instructions:
* Eager load all plugins you add by default (`lazy = false`).
* Use the `keys` option to define key mappings for plugins where possible.
* C-s is my tmux leader key, so don't use that for anything.
* Stick to the LazyVim capabilities where possible and enable extras rather than adding plugins manually.
* Keep any plugin config to a minimum and don't add common defaults.
* Keep longer function in helper module in `lua/user/`.
* Verify your changes worked by starting neovim in headless mode.
  * Ensure lazy installs any newly added plugins.
  * Set the `NVIM_APPNAME` to the current working directory when invoking nvim.
* Always format changed files.
* Do not commit any changes!
