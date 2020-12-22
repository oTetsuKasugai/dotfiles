" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

lua << END
local plugins = {
  ["completion-nvim"] = {
    config = { "\27LJ\2\n]\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0\28packadd vim-vsnip-integ\22packadd vim-vsnip\bcmd\bvim\0" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/tetsu/.local/share/nvim/site/pack/packer/opt/completion-nvim"
  },
  ["dart-vim-plugin"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/tetsu/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin"
  },
  ["deoplete-tabnine"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/tetsu/.local/share/nvim/site/pack/packer/opt/deoplete-tabnine"
  },
  ["packer.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/tetsu/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  tabular = {
    commands = { "Tabular" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/tetsu/.local/share/nvim/site/pack/packer/opt/tabular"
  },
  ["vim-markdown"] = {
    config = { "let g:markdown_enable_spell_checking = 0" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/tetsu/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-rails"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/tetsu/.local/share/nvim/site/pack/packer/opt/vim-rails"
  },
  ["vim-toml"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/tetsu/.local/share/nvim/site/pack/packer/opt/vim-toml"
  },
  ["vim-vsnip"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/tetsu/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/tetsu/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

_packer_load = nil

local function handle_after(name, before)
  local plugin = plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    _packer_load({name}, {})
  end
end

_packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if plugins[name].commands then
      for _, cmd in ipairs(plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if plugins[name].keys then
      for _, key in ipairs(plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      if plugins[name].config then
        for _i, config_line in ipairs(plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if plugins[name].after then
        for _, after_name in ipairs(plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    -- NOTE: I'm not sure if the below substitution is correct; it might correspond to the literal
    -- characters \<Plug> rather than the special <Plug> key.
    vim.fn.feedkeys(string.gsub(string.gsub(cause.keys, '^<Plug>', '\\<Plug>') .. extra, '<[cC][rR]>', '\r'))
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

-- Runtimepath customization

-- Pre-load configuration
-- Post-load configuration
-- Config for: fern-renderer-nerdfont.vim
loadstring('let g:fern#renderer = "nerdfont"')()
-- Config for: nvim-lspconfig
loadstring("\27LJ\2\nA\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\"call hook#add#nvim_lsp#load()\bcmd\bvim\0")()
-- Config for: sonokai
loadstring("colorscheme sonokai")()
-- Conditional loads
-- Load plugins in order defined by `after`
END

function! s:load(names, cause) abort
call luaeval('_packer_load(_A[1], _A[2])', [a:names, a:cause])
endfunction


" Command lazy-loads
command! -nargs=* -range -bang -complete=file Tabular call s:load(['tabular'], { "cmd": "Tabular", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })

" Keymap lazy-loads

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType markdown ++once call s:load(['vim-markdown'], { "ft": "markdown" })
  au FileType dart ++once call s:load(['dart-vim-plugin'], { "ft": "dart" })
  au FileType toml ++once call s:load(['vim-toml'], { "ft": "toml" })
  au FileType ruby ++once call s:load(['vim-rails'], { "ft": "ruby" })
  " Event lazy-loads
  au InsertEnter * ++once call s:load(['completion-nvim'], { "event": "InsertEnter *" })
  au VimEnter * ++once call s:load(['deoplete-tabnine'], { "event": "VimEnter *" })
augroup END
