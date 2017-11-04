local wibox     = require("wibox")
local beautiful = require("beautiful")
local awful     = require("awful")
local lain      = require("lain")
local vicious   = require("vicious")

-- Settings

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

-- Set tooltip colors
beautiful.tooltip_bg_color = col8
beautiful.tooltip_fg_color = col7

-- {{{ Wibox
markup = lain.util.markup
blue   = col7
space3 = markup.font("Tamsyn 3", " ")
space2 = markup.font("Tamsyn 2", " ")

-- Battery
-- 
batwidget = lain.widgets.bat({
    settings = function()

        if bat_now.status == "Charging" then
            bat_p = bat_now.perc .. "^"
        else
            bat_p = bat_now.perc .. "%"
        end

        if bat_now.perc >= '100' then
            bat_header = " <span color='" .. col_ok .. "'>" .. "" .. "</span> "
        end
        if bat_now.perc <= '99' then
            bat_header = " <span color='" .. col_ok .. "'>" .. "" .. "</span> "
        end
        if bat_now.perc <= '60' then
            bat_header = " <span color='" .. col_no .. "'>" .. "" .. "</span> "
        end
        if bat_now.perc <= '20' then
            bat_header = " <span color='" .. col_wa .. "'>" .. "" .. "</span> "
        end

        if bat_now.status == "Not present" then
            bat_header = ""
            bat_p      = ""
        end
        widget:set_markup(markup(blue, bat_header) .. bat_p)
    end
})

--] VPN Widget Start
vpnwidget = wibox.widget.textbox()
vpnwidget:set_text(" VPN: N/A ")
vpnwidgettimer = timer({ timeout = 5 })
vpnwidgettimer:connect_signal("timeout",
  function()
    status = io.popen("ls /var/run | grep 'openvpn'", "r")
    if status:read() == nil then
        vpnwidget:set_markup(" <span color='" .. col_wa .. "'>VPN</span> ")
    else
        vpnwidget:set_markup(" <span color='" .. col_ok .. "'>VPN</span> ")
    end
    status:close()
  end
)
vpnwidgettimer:start()
--] VPN Widget End

--] DNScrypt Widget Start
dnscryptwidget = wibox.widget.textbox()
dnscryptwidget:set_text(" DNScrypt: N/A ")
dnscryptwidgettimer = timer({ timeout = 5 })
dnscryptwidgettimer:connect_signal("timeout",
  function()
    status = io.popen("ps -u dnscrypt | grep 'dnscrypt-proxy'", "r")
    if status:read() == nil then
        dnscryptwidget:set_markup(" <span color='" .. col_wa .. "'>DNScrypt</span> ")
    else
        dnscryptwidget:set_markup(" <span color='" ..col_ok .. "'>DNScrypt</span> ")
    end
    status:close()
  end
)
dnscryptwidgettimer:start()
--] DNScrypt Widget End

-- Clock
mytextclock = awful.widget.textclock(markup(col7, space3 .. "%H:%M" .. space2))
clock_icon = wibox.widget.imagebox()
clock_icon:set_image(beautiful.clock)
clockwidget = wibox.widget.background()
clockwidget:set_widget(mytextclock)
clockwidget:set_bgimage(beautiful.widget_bg)

-- Calendar
mytextcalendar = awful.widget.textclock(markup("#FFFFFF", space3 .. "%d %b<span font='DejaVu Sans Mono 8'> </span>"))
calendar_icon = wibox.widget.imagebox()
calendar_icon:set_image(beautiful.calendar)
calendarwidget = wibox.widget.background()
calendarwidget:set_widget(mytextcalendar)
calendarwidget:set_bgimage(beautiful.widget_bg)
lain.widgets.calendar:attach(calendarwidget, { fg = "#FFFFFF", position = "bottom_left" })

-- MPD
mpd_icon = wibox.widget.imagebox()
mpd_icon:set_image(beautiful.mpd)
prev_icon = wibox.widget.imagebox()
prev_icon:set_image(beautiful.prev)
next_icon = wibox.widget.imagebox()
next_icon:set_image(beautiful.nex)
stop_icon = wibox.widget.imagebox()
stop_icon:set_image(beautiful.stop)
pause_icon = wibox.widget.imagebox()
pause_icon:set_image(beautiful.pause)
play_pause_icon = wibox.widget.imagebox()
play_pause_icon:set_image(beautiful.play)

mpdwidget = lain.widgets.mpd({
    settings = function ()
        if mpd_now.state == "play" then
            mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
            mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
            widget:set_markup(markup.font("Tamsyn 4", " ")
                              .. markup.font("Tamsyn 8",
                              mpd_now.artist
                              .. " - " ..
                              mpd_now.title
                              .. markup.font("Tamsyn 10", " ")))
            play_pause_icon:set_image(beautiful.pause)
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font("Tamsyn 4", " ") ..
                              markup.font("Tamsyn 8", "MPD PAUSED") ..
                              markup.font("Tamsyn 10", " "))
            play_pause_icon:set_image(beautiful.play)
        else
            widget:set_markup("")
            play_pause_icon:set_image(beautiful.play)
        end
    end
})

musicwidget = wibox.widget.background()
musicwidget:set_widget(mpdwidget)
musicwidget:set_bgimage(beautiful.widget_bg)
musicwidget:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(musicplr) end)))
mpd_icon:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(musicplr) end)))
prev_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.util.spawn_with_shell("mpc prev || ncmpc prev || pms prev")
    mpdwidget.update()
end)))
next_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.util.spawn_with_shell("mpc next || ncmpc next || pms next")
    mpdwidget.update()
end)))
stop_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    play_pause_icon:set_image(beautiful.play)
    awful.util.spawn_with_shell("mpc stop || ncmpc stop || pms stop")
    mpdwidget.update()
end)))
play_pause_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.util.spawn_with_shell("mpc toggle || ncmpc toggle || pms toggle")
    mpdwidget.update()
end)))


-- █▓▒░  CPU
cpu_widget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(cpu_now.usage .. "%" .. markup.font("Tamsyn 5", " "))
    end
})
cpuwidget = wibox.widget.background()
cpuwidget:set_widget(cpu_widget)
cpuwidget:set_bgimage(beautiful.widget_bg)
cpu_icon = wibox.widget.imagebox()
cpu_icon:set_image(beautiful.cpu)
cpu_icon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell("termite -e 'htop'") end)))

-- Net
netdown_icon = wibox.widget.imagebox()
netdown_icon:set_image(beautiful.net_down)
netup_icon = wibox.widget.imagebox()
netup_icon:set_image(beautiful.net_up)
netwidget = lain.widgets.net({
    settings = function()
        widget:set_markup("<span color='" .. col_ok .. "'>" .. net_now.received .. "</span> "
                          .. "<span color='" .. col_wa .. "'>" .. net_now.sent .. "</span>")
    end
})
networkwidget = wibox.widget.background()
networkwidget:set_widget(netwidget)
networkwidget:set_bgimage(beautiful.widget_bg)


-- █▓▒░  Weather
myweather = lain.widgets.weather({
    city_id = 2673730 -- placeholder (Stockholm)
})

-- █▓▒░  Separators
first = wibox.widget.textbox('<span font="Tamsyn 4"> </span>')
last = wibox.widget.imagebox()
last:set_image(beautiful.last)
bigspr = wibox.widget.textbox('    ')
spr = wibox.widget.imagebox()
spr:set_image(beautiful.spr)
spr_small = wibox.widget.imagebox()
spr_small:set_image(beautiful.spr_small)
spr_very_small = wibox.widget.imagebox()
spr_very_small:set_image(beautiful.spr_very_small)
spr_right = wibox.widget.imagebox()
spr_right:set_image(beautiful.spr_right)
spr_bottom_right = wibox.widget.imagebox()
spr_bottom_right:set_image(beautiful.spr_bottom_right)
spr_left = wibox.widget.imagebox()
spr_left:set_image(beautiful.spr_left)
bar = wibox.widget.imagebox()
bar:set_image(beautiful.bar)
bottom_bar = wibox.widget.imagebox()
bottom_bar:set_image(beautiful.bottom_bar)

-- █▓▒░  Create a wibox for each screen and add it
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
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
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
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)


--[ Top wibox
-------------
    mywibox[s] = awful.wibox({ position = "top", screen = s, border_width = 0, height = 26 })

--{ Top left }--
    local left_layout = wibox.layout.fixed.horizontal()
    -- left_layout:add(calendar_icon)
    -- left_layout:add(clock_icon)
    left_layout:add(spr_very_small)
    left_layout:add(calendarwidget)
    left_layout:add(spr_very_small)
    left_layout:add(clockwidget)
    left_layout:add(bigspr)
    left_layout:add(mypromptbox[s])

--{ Top middle }--
    local middle_layout = wibox.layout.fixed.horizontal()
    middle_layout:add(mytaglist[s])
    middle_layout:add(spr_very_small)
    middle_layout:add(mylayoutbox[s])

--{ Top right }--
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(vpnwidget)
    right_layout:add(dnscryptwidget)
    if show_systray == 1 then right_layout:add(wibox.widget.systray()) end

--{ Show }--
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(middle_layout)
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)

--[ Bottom wibox
----------------
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 26 })

--{ Bottom left }--
    bottom_left_layout = wibox.layout.fixed.horizontal()
    bottom_left_layout:add(bigspr)

--{ Bottom right }--
    bottom_right_layout = wibox.layout.fixed.horizontal()
    bottom_right_layout:add(bigspr)
    bottom_right_layout:add(netdown_icon)
    bottom_right_layout:add(networkwidget)
    bottom_right_layout:add(netup_icon)
    bottom_right_layout:add(spr_very_small)
    bottom_right_layout:add(cpu_icon)
    bottom_right_layout:add(cpuwidget)
    bottom_right_layout:add(spr_very_small)
    bottom_right_layout:add(batwidget)

--{ Show }--
    bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_middle(mytasklist[s])
    bottom_layout:set_right(bottom_right_layout)
    mybottomwibox[s]:set_widget(bottom_layout)
--]

    -- Set proper backgrounds, instead of beautiful.bg_normal
    --mywibox[s]:set_bg(beautiful.topbar_path .. math.floor((screen[mouse.screen].workarea.width)) .. ".png")
--    mybottomwibox[s]:set_bg("#17130d")
end
