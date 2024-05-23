# iswap.nvim

> [!TIP]
> If you're getting an error updating this repository, **delete it, and install
> it again**! See [#58](https://github.com/mizlan/iswap.nvim/issues/58) for details.

Interactively select and swap: function arguments, list elements, function
parameters, and more. Powered by tree-sitter.

https://user-images.githubusercontent.com/44309097/185752788-6e9defdd-7d19-4700-9b7d-e5bc5d95b0d2.mov

## installation

For vim-plug:

```vim
Plug 'mizlan/iswap.nvim'
```

For [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
{
  "mizlan/iswap.nvim",
  event = "VeryLazy"
}
```

## usage

Run the command `:ISwap` when your cursor is in a location that is suitable for
swapping around things. These include lists/arrays, function arguments, and
parameters in function definitions. Then, hit two keys corresponding to the
items you wish to be swapped. After both keys are hit, the text should
immediately swap in the buffer. See the gif above for example usage.

Use `:ISwapWith` if you want to have the element your cursor is over
automatically as one of the elements. This way, you only need one keypress to
make a swap.

Use `:ISwapNode` to swap two arbitrary adjacent nodes. Again, `:ISwapNodeWith`
picks the cursor element automatically as one of the elements.
`:ISwapNodeWith{Left,Right}` are provided as shortcuts to swap the cursor node
with its immediate left and right node respectively.

For all of the above commands, there is an equivalent `:IMove*` command that
will 'move' the node to the chosen position, rather than swapping. This is
equivalent to swapping the first node with all of the nodes up to and including
the second node.

For `I(Swap|Move)(With)?` you can bind it to a key in visual mode to influence
node selection.

## configuration

In your `init.lua`:

```lua
require('iswap').setup{
  -- The keys that will be used as a selection, in order
  -- ('asdfghjklqwertyuiopzxcvbnm' by default)
  keys = 'qwertyuiop',

  -- Grey out the rest of the text when making a selection
  -- (enabled by default)
  grey = 'disable',

  -- Highlight group for the sniping value (asdf etc.)
  -- default 'Search'
  hl_snipe = 'ErrorMsg',

  -- Highlight group for the visual selection of terms
  -- default 'Visual'
  hl_selection = 'WarningMsg',

  -- Highlight group for the greyed background
  -- default 'Comment'
  hl_grey = 'LineNr',

  -- Post-operation flashing highlight style,
  -- either 'simultaneous' or 'sequential', or false to disable
  -- default 'sequential'
  flash_style = false,

  -- Highlight group for flashing highlight afterward
  -- default 'IncSearch'
  hl_flash = 'ModeMsg',

  -- Move cursor to the other element in ISwap*With commands
  -- default false
  move_cursor = true,

  -- Automatically swap with only two arguments
  -- default false
  autoswap = true,

  -- Keys that will use to expand the list/node that you are swapping within
  -- Choose a key that is not in the `keys` config otherwise it won't work
  expand_key = 'z'

  -- Other default options you probably should not change:
  debug = nil,
  hl_grey_priority = '1000',
}
```

inspired by [hop.nvim](https://github.com/phaazon/hop.nvim) and
[nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)

## TODO

- Change defaults?
- `ISwap[Node]With`: Visual mode selection to move/swap multiple nodes at once
- `ISwap[Node]With`: Incremental mode while labels are visible (DONE: FIX BUGS)
- Remove all mentions of `ts_utils`, clason is going to smite it out of existence
