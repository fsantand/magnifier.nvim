# magnifier.nvim

> An scope for telescope

This plugin aims to have tools to narrow down monorepos that are too big to just search with fd and
you are too lazy to just download fzf.

This would be per project/root

## Requirements

- `telescope-nvim/telescope.nvim`
- `nvim-tree/nvim-tree.lua`

## Install

Install with your favourite package manager:

```
fsantand/magnifier.nvim
```

Then, add the setup to your plugins file

## Usage

Run the following commands

- `:MagnifierAdd` : Adds a new directory to the monorepo scope
- `:MagnifierRefresh` : Refreshes the current scoped workspace, in case it fails
- `:MagnifierSet` : Adds a new directory to the monorepo scope
- `:MagnifierRemove` : Removes a directory from the monorepo scope
- `:MagnifierList` : Shows a loclist/qflist with all the currently set directories
- `:MagnifierFindFiles` : Search for files in telescope with scoped dirs
- `:MagnifierGrepFiles` : Run grep inside the scoped directories

## Motivation

I have worked with monorepos all my life, but in my current job there are this big ass
monorepos that hog all the telescope extension I usually use to search for any given 
file. So I came up with the idea just to learn how to create plugins in vim, since I
really love neovim

## To Do

- [ ] Persist saved scopes (a la [workspaces.nvim](https://github.com/natecraddock/workspaces.nvim))
- [ ] Add configuration options, since not everyone wants an augroup
