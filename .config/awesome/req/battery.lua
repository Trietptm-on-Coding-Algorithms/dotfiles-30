-- Battery
-- ( fontawesome  )

local wibox = require("wibox")
local awful = require("awful")
local lain  = require("lain")
local naughty = require("naughty")

batwidget = lain.widgets.bat({
    settings = function()

        --[[ Don't want extra info right now
        if bat_now.status == "Charging" then
            bat_p = bat_now.perc .. "^"
        else
            bat_p = bat_now.perc .. "%"
        end
        ]]--

        if (bat_now.perc > '0' and bat_now.perc < '15') then
            bat_header = " <span color='" .. col_wa .. "'>" .. "" .. "</span> "

        elseif (bat_now.perc > '15' and bat_now.perc < '40') then
            bat_header = " <span color='" .. col_wa .. "'>" .. "" .. "</span> "
        elseif (bat_now.perc > '40' and bat_now.perc < '70') then
            bat_header = " <span color='" .. col_no .. "'>" .. "" .. "</span> "
        elseif (bat_now.perc > '70' and bat_now.perc < '90') then
            bat_header = " <span color='" .. col_ok .. "'>" .. "" .. "</span> "
        elseif (bat_now.perc > '90' and bat_now.perc < '100') then
            bat_header = " <span color='" .. col_ok .. "'>" .. "" .. "</span> "
        end

        if bat_now.status == "Not present" then
            bat_header = ""
            bat_p      = ""
        end
        -- widget:set_markup(markup(blue, bat_header) .. bat_p)
        widget:set_markup(markup(blue, bat_header))
    end
})

local bat_notification
function battery_status()
    awful.spawn.easy_async([[bash -c 'acpi']],
        function(stdout, _, _, _)
            bat_notification = naughty.notify{
                text =  stdout,
                title = "Battery status",
                position = "top_right",
                fg = tooltip_fg_color,
                bg = tooltip_bg_color,
                timeout = 5, hover_timeout = 0.5,
                -- width = 200,
            }
        end
    )
end
batwidget:connect_signal("mouse::enter", function() battery_status() end)
batwidget:connect_signal("mouse::leave", function() naughty.destroy(bat_notification) end)
