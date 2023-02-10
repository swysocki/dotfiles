local wezterm = require 'wezterm'

local gruvbox = wezterm.get_builtin_color_schemes()['Gruvbox dark, medium (base16)']
gruvbox.background = '#303030'

return {
  color_schemes = {
    ['My Theme'] = gruvbox,
  },
  color_scheme = 'My Theme',
  font_size = 12.0,
  hide_tab_bar_if_only_one_tab = true
}
