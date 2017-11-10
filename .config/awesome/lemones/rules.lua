local awful     = require("awful")
local beautiful = require("beautiful")

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
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

    { rule = { class = "Dwb" },
          properties = { tag = tags[1][1] } },

    { rule = { class = "Iron" },
          properties = { tag = tags[1][1] } },

    { rule = { instance = "plugin-container" },
          properties = { tag = tags[1][1] } },

	  { rule = { class = "Gimp" },
     	    properties = { tag = tags[1][4] } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized_horizontal = true,
                         maximized_vertical = true } },
--  Firefox
    { rule = { class = "firefox" },
        properties = { }, callback = function (c)
                    if not skipMovingFF then
                    awful.client.movetotag(tags[1][2], c)
                      skipMovingFF = true
                    end
      end },

      { rule = { class = "urxvt" },
            properties = { }, callback = function (c)
                          if not skipMovingFF then
                          awful.client.movetotag(tags[1][1], c)
                            skipMovingFF = true
                          end
            end },
}
}
-- }}}
