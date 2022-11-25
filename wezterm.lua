local wezterm = require("wezterm")

local config = {
  color_scheme = "Nord (base16)",
  font_size = 12.0,
  enable_tab_bar = true,
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.font_size = 10.0
  config.default_prog = {'powershell'}
end

return config
