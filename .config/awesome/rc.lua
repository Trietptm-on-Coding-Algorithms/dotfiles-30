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
local lain      = require("lain")
-- require("req.battery")
require("req.clock")

--[[       ]]--
--[[ Debug ]]--
--[[       ]]--
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

--[[           ]]--
--[[ Autostart ]]--
--[[           ]]--
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

--run_once("urxvtd")
run_once("unclutter -root")

--[[        ]]--
--[[ Config ]]--
--[[        ]]--
-- Set theme
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/bnka/theme.lua")

-- colors
col_ok                  = "#559363" -- OK color
col_no                  = "#d6cf6b" -- Not OK color
col_wa                  = "#783232" -- Warning color
col_sprtr               = "#b3b3b3" -- Separator color

dmenu_nb                = "#2D292E" -- Background color
dmenu_nf                = "#2D292E" -- Normal color
dmenu_nb                = "#FF476A" -- Selected color
dmenu_sb                = "#FFFFFF" -- Selected background color

-- Set tooltip colors
beautiful.tooltip_bg_color = col8
beautiful.tooltip_fg_color = col7
dmenu_preg = "dmenu_run -b -nf '#FFFFFF' -sb '#2D292E' -nb '#2D292E' -sf '#FF476A' -p Run: -l 5"
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
show_cpu_percent        = true
show_battery_percent    = true
show_net_up_down        = true
show_calendar           = true
show_clock              = true
show_alsabuttons        = false
show_systray            = false


-- {{{ Wibox
markup = lain.util.markup
blue   = col7
space3 = markup.font("Tamsyn 3", " ")
space2 = markup.font("Tamsyn 2", " ")

--[[        ]]--
--[[ Layout ]]--
--[[        ]]--
local layouts = {
    awful.layout.suit.floating,   -- 1
    lain.layout.uselesstile,      -- 2
    awful.layout.suit.fair,       -- 3
    lain.layout.uselesstile.left, -- 4
    lain.layout.uselesstile.top,  -- 5
    lain.layout.centerwork,       -- 6
    lain.layout.centerworkd,      -- 7
    lain.layout.uselesspiral      -- 8
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
     layouts[6],
     layouts[7]
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

--[[             ]]--
--[[ Keybindings ]]--
--[[             ]]--
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 9, awful.tag.viewnext),
    awful.button({ }, 8, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Special Keys
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q sset Master 5%+") end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q sset Master 5%-") end),
    awful.key({ }, "XF86Calculator", function () awful.util.spawn("gnome-calculator") end),
    awful.key({ altkey }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
      awful.key({ modkey }, "Down",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
      awful.key({ modkey }, "Up",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
      awful.key({ modkey }, "Left",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
      awful.key({ modkey }, "Right",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "b",
        function ()
            mywibox[mouse.screen.index].visible = not mywibox[mouse.screen.index].visible
            mybottomwibox[mouse.screen.index].visible = not mybottomwibox[mouse.screen.index].visible
        end),

    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end),
    awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    awful.key({ modkey,           }, "+",      function () awful.tag.incmwfact( 0.05)     end),
    awful.key({ modkey,           }, "-",      function () awful.tag.incmwfact(-0.05)     end),
    awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
    awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
    awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
    awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
    awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
    awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
    awful.key({ modkey, "Control" }, "n",      awful.client.restore),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r",      awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",      awesome.quit),
    awful.key({ altkey,           }, "c",      function () lain.widgets.calendar:show(7) end),
    -- MPD control
    awful.key({ altkey, "Control" }, "Up",     function () awful.util.spawn_with_shell("mpc toggle || ncmpc toggle || pms toggle") end),
    awful.key({ altkey, "Control" }, "Down",   function () awful.util.spawn_with_shell("mpc stop || ncmpc stop || pms stop") end),
    awful.key({ altkey, "Control" }, "Left",   function () awful.util.spawn_with_shell("mpc prev || ncmpc prev || pms prev") end),
    awful.key({ altkey, "Control" }, "Right",  function () awful.util.spawn_with_shell("mpc next || ncmpc next || pms next") end),

    awful.key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),
    awful.key({ modkey }, "q", function () awful.util.spawn(browser) end),
    awful.key({ modkey }, "i", function () awful.util.spawn(browser2) end),
    awful.key({ modkey }, "s", function () awful.util.spawn(gui_editor) end),
    awful.key({ modkey }, "g", function () awful.util.spawn(graphics) end),
    awful.key({ modkey }, "r", function () os.execute(dmenu_preg) end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c) c.maximized_horizontal = not c.maximized_horizontal c.maximized_vertical = not c.maximized_vertical end)
)

for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

--[[             ]]--
--[[ Design      ]]--
--[[             ]]--
-- ] Separators
sprtr = wibox.widget.textbox()
sprtr:set_markup("<span color='" .. col_sprtr .. "'> : </span>")
sprtr_hidden = wibox.widget.textbox()
sprtr_hidden:set_markup("<span color='" .. col_sprtr .. "'>  </span>")

--] VPN Widget Start
vpnwidget = wibox.widget.textbox()
vpnwidget:set_text(" VPN: N/A ")
vpnwidgettimer = timer({ timeout = 5 })
vpnwidgettimer:connect_signal("timeout",
  function()
    status = io.popen("ls /var/run | grep 'openvpn'", "r")
    if status:read() == nil then
        vpnwidget:set_markup("<span color='" .. col_wa .. "'>VPN</span>")
    else
        vpnwidget:set_markup("<span color='" .. col_ok .. "'>VPN</span>")
    end
    status:close()
  end
)
vpnwidgettimer:start()

--] DNScrypt Widget Start
dnscryptwidget = wibox.widget.textbox()
dnscryptwidget:set_text(" DNScrypt: N/A ")
dnscryptwidgettimer = timer({ timeout = 5 })
dnscryptwidgettimer:connect_signal("timeout",
  function()
    status = io.popen("ps -u dnscrypt | grep 'dnscrypt-proxy'", "r")
    if status:read() == nil then
        dnscryptwidget:set_markup("<span color='" .. col_wa .. "'>DNScrypt</span>")
    else
        dnscryptwidget:set_markup("<span color='" ..col_ok .. "'>DNScrypt</span>")
    end
    status:close()
  end
)
dnscryptwidgettimer:start()

mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    mypromptbox[s] = awful.widget.prompt()
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

--{ Top wibox }--
    mywibox[s] = awful.wibox({ position = "top", screen = s, border_width = 0, height = 26 })

--{ Top left }--
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(sprtr_hidden)
    left_layout:add(mypromptbox[s])

--{ Top middle }--
    local middle_layout = wibox.layout.fixed.horizontal()
    middle_layout:add(sprtr_hidden)
    middle_layout:add(mytaglist[s])
    middle_layout:add(sprtr)
    middle_layout:add(mylayoutbox[s])

--{ Top right }--
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(vpnwidget)
    right_layout:add(sprtr)
    right_layout:add(dnscryptwidget)
    right_layout:add(sprtr)
    right_layout:add(mytextclock)
    right_layout:add(sprtr_hidden)
    if show_systray == 1 then right_layout:add(wibox.widget.systray()) end

--{ Show }--
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(middle_layout)
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)

--[ Bottom wibox }--
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 26 })

--{ Bottom left }--
    bottom_left_layout = wibox.layout.fixed.horizontal()
    bottom_left_layout:add(sprtr_hidden)

--{ Bottom right }--
    bottom_right_layout = wibox.layout.fixed.horizontal()
    bottom_right_layout:add(sprtr_hidden)

--{ Show }--
    bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_middle(mytasklist[s])
    bottom_layout:set_right(bottom_right_layout)
    mybottomwibox[s]:set_widget(bottom_layout)
end


--[[       ]]--
--[[ Rules ]]--
--[[       ]]--
awful.rules.rules = {
    -- One rule to rule them all
    { rule = { },
      properties = {
          border_width = beautiful.border_width,
          border_color = beautiful.border_normal,
          focus = awful.client.focus.filter,
          keys = clientkeys,
          buttons = clientbuttons,
          size_hints_honor = false
        }
    },
    { rule = { class = "URxvt" },
          --properties = { tag = tags[1][1] } },
    { rule = { class = "MPlayer" },
          properties = { floating = true } },
    { rule = { class = "vlc" },
	  properties = { floating = true } },
    }
}

--[[         ]]--
--[[ Signals ]]--
--[[         ]]--
-- Signal function to execute when a new client appears.
local sloppyfocus_last = {c=nil}
client.connect_signal("manage", function (c, startup)

  -- Put windows in a smart way, only if they does not set an initial position.
    awful.placement.no_overlap(c)
    awful.placement.no_offscreen(c)

    -- Enable sloppy focus
    client.connect_signal("mouse::enter", function(c)
         if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
             -- Skip focusing the client if the mouse wasn't moved.
             if c ~= sloppyfocus_last.c then
                 client.focus = c
                 sloppyfocus_last.c = c
             end
         end
     end)

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c,{size=16}):set_widget(layout)
    end
end)

client.connect_signal("focus",
    function(c)
        if c.maximized_horizontal == true and c.maximized_vertical == true then
            c.border_color = beautiful.border_normal
        else
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))
        if #clients > 0 then -- Fine grained borders and floaters control
            for _, c in pairs(clients) do -- Floaters always have borders
                if awful.client.floating.get(c) or layout == "floating" then
                    c.border_width = beautiful.border_width
                elseif #clients == 1 or layout == "max" then
                    c.border_width = 0
                else
                    c.border_width = beautiful.border_width
                end
            end
        end
      end)
end
