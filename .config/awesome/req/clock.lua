local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")

mytextclock = wibox.widget.textclock("%H:%M")

local cal_notification
function cal_show()
    awful.spawn.easy_async([[bash -c 'cal -n 2 -m']],
        function(stdout, _, _, _)
            cal_notification = naughty.notify{
                text =  stdout,
                position = "top_right",
                fg = tooltip_fg_color,
                bg = tooltip_bg_color,
                timeout = 5, hover_timeout = 0.5,
            }
        end
    )
end
mytextclock:connect_signal("mouse::enter", function() cal_show() end)
mytextclock:connect_signal("mouse::leave", function() naughty.destroy(cal_notification) end)
