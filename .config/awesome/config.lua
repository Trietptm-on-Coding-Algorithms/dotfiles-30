--[[
  ░█▀▄░█▀█░█▀▄░█▀█░█▀█░█░█░█▀█░░░░█▀█░█▀▄░█▀▀
 ░█▀▄░█▀█░█░█░█▀█░█░█░█▀▄░█▀█░░░░█░█░█▀▄░█░█
░▀▀░░▀░▀░▀▀░░▀░▀░▀░▀░▀░▀░▀░▀░▀░░▀▀▀░▀░▀░▀▀▀
                https://github.com/lemones/dotfiles/
]]--

local beautiful = require("beautiful")
local lain      = require("lain")

-- Set theme
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/akhaten/theme.lua")

modkey     = "Mod4"
altkey     = "Mod1"
terminal   = "urxvtc" or "xterm"
editor     = os.getenv("EDITOR") or "nano" or "vi"
editor_cmd = terminal .. " -e " .. editor

browser    = "firefox"
browser2   = "google-chrome-stable"
gui_editor = "atom"
graphics   = "gimp"
musicplr   = terminal .. " -e ncmpcpp "


-- Layout Settings

show_infotext           = true
show_cpu_percent        = true
show_battery_percent    = true
show_net_up_down        = true
show_calendar           = true
show_clock              = true
show_alsabuttons        = false
show_systray            = false

-- colors
col_ok                  = "#559363" -- OK color
col_no                  = "#d6cf6b" -- Not OK color
col_wa                  = "#783232" -- Warning color
col_sprtr               = "#b3b3b3" -- Separator color

-- Set tooltip colors
beautiful.tooltip_bg_color = col8
beautiful.tooltip_fg_color = col7

-- {{{ Wibox
markup = lain.util.markup
blue   = col7
space3 = markup.font("Tamsyn 3", " ")
space2 = markup.font("Tamsyn 2", " ")
