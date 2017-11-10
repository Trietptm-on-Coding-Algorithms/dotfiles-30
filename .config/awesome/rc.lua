--[[
  ░█▀▄░█▀█░█▀▄░█▀█░█▀█░█░█░█▀█░░░░█▀█░█▀▄░█▀▀
 ░█▀▄░█▀█░█░█░█▀█░█░█░█▀▄░█▀█░░░░█░█░█▀▄░█░█
░▀▀░░▀░▀░▀▀░░▀░▀░▀░▀░▀░▀░▀░▀░▀░░▀▀▀░▀░▀░▀▀▀
                https://github.com/lemones/dotfiles/
]]--

local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local drop      = require("scratchdrop")
local lain      = require("lain")
local treesome  = require("treesome")
local alttab    = require("alttab")

require("lemones/debug")
require("lemones/autostart")
require("config")

local layouts = {
    awful.layout.suit.floating,
    lain.layout.uselesstile,
    awful.layout.suit.fair,
    lain.layout.uselesstile.left,
    lain.layout.uselesstile.top,
    lain.layout.centerwork,
    treesome
}

tags = {
   names = {
	"",
	"",
	"",
	"",
	"",
    },
   layout = {
     layouts[1],
     layouts[1],
     layouts[4],
     layouts[1],
     layouts[3]
  }
}

for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

--[[ MENU (disabled due to errors)
 mymainmenu = awful.menu.new({ items = require("menugen").build_menu(),
                              theme = {
                              height = 16,
                              width = 130,
                              bg_normal = theme_menu_bg_color,
                              fg_normal = theme_menu_fg_color,
                              bg_focus = theme_menu_bg_focus,
                              fg_focus = theme_menu_fg_focus,
                              border_color = theme_menu_border_color,
                              border_width = theme_menu_border_size
                          }})
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
]]--

-- Include keybindings
require "lemones/keybindings"
-- Include layout
require "lemones/layout"
-- Include rules
require "lemones/rules"
-- Include Signals
require "lemones/signals"
