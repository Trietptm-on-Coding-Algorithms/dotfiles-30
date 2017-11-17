
--[[ bnka
 _             _           _
| |__  __ _ __| |__ _ _ _ | |____ _   ___ _ _ __ _
| '_ \/ _` / _` / _` | ' \| / / _` |_/ _ \ '_/ _` |
|_.__/\__,_\__,_\__,_|_||_|_\_\__,_(_)___/_| \__, |
                                             |___/
--]]

col0  = '#0e1425'
col1  = '#d9e6f2'
col2  = '#242a5b'
col3  = '#3b4072'
col4  = '#a45959'
col5  = '#dbbdbd'
col6  = '#59a459'
col7  = '#bddbbd'
col8  = '#a4a459'
col9  = '#dbdbbd'
col10 = '#5959a4'
col11 = '#bdbddb'
col12 = '#a459a4'
col13 = '#dbbddb'
col14 = '#59a4a4'
col15 = '#bddbdb'
col16 = '#aab0e1'
col17 = '#bbc0f2'
col18 = '#9b69cf' --taglist, tasklist-selected-border, tooltip-border
col19 = '#8237cf' -- focus-border


theme                               = {}
theme.icon_dir                      = os.getenv("HOME") .. "/.config/awesome/themes/bnka/icons"
theme.wallpaper                     = os.getenv("HOME") .. "/.config/awesome/themes/bnka/wall.png"
theme.font                          = "Monospace 8"
theme.taglist_font  	            = "FontAwesome 8"
theme.topbar_path                   = "png:" .. theme.icon_dir .. "/topbar/"


-- Foreground
theme.fg_normal                     = col7
theme.fg_urgent                     = col7

-- Focus
theme.fg_focus                      = col7
theme.taglist_fg_focus              = col7
theme.tasklist_fg_focus             = col7

-- Background
theme.bg_normal                     = col0 .. "90" -- Taskbar background
theme.bg_urgent                     = col0
theme.tasklist_bg_normal            = col0 .. "00"

-- Focus
theme.taglist_bg_focus              = "png:" .. theme.icon_dir .. "/taglist_bg_focus.png"
theme.tasklist_bg_focus             = "png:" .. theme.icon_dir .. "/bg_focus.png"

theme.border_focus                  = col19
theme.border_width                  = "1"
theme.border_normal                 = col0

theme.textbox_widget_margin_top     = 1
theme.awful_widget_height           = 14
theme.awful_widget_margin_top       = 2

-- tooltip
tooltip_font                        = "Monospace 10"
--tooltip_opacity                     = "1"
tooltip_fg_color                    = col7
tooltip_bg_color                    = col0 .. "90"
tooltip_border_width                = "1"
tooltip_border_color                = col18

theme_menu_bg_color                       = col1
theme_menu_fg_color                       = col7
theme_menu_bg_focus                       = col1
theme_menu_fg_focus                       = col5
theme_menu_border_color                   = col5
theme_menu_border_size                    = 1

theme.taglist_fg_focus    = col13
theme.taglist_fg_occupied = col11
theme.taglist_fg_urgent   = "#ED7572"
theme.taglist_fg_empty    = col11
theme.taglist_spacing     = 2


theme.awesome_icon                  = theme.icon_dir .. "/awesome_icon.png"
-- Squares around taglist
theme.taglist_squares_sel           = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel         = theme.icon_dir .. "/square_unsel.png"

theme.layout_tile                   = theme.icon_dir .. "/tile.png"
theme.layout_tilegaps               = theme.icon_dir .. "/tilegaps.png"
theme.layout_tileleft               = theme.icon_dir .. "/tileleft.png"
theme.layout_tilebottom             = theme.icon_dir .. "/tilebottom.png"
theme.layout_tiletop                = theme.icon_dir .. "/tiletop.png"
theme.layout_fairv                  = theme.icon_dir .. "/fairv.png"
theme.layout_fairh                  = theme.icon_dir .. "/fairh.png"
theme.layout_spiral                 = theme.icon_dir .. "/spiral.png"
theme.layout_dwindle                = theme.icon_dir .. "/dwindle.png"
theme.layout_max                    = theme.icon_dir .. "/max.png"
theme.layout_fullscreen             = theme.icon_dir .. "/fullscreen.png"
theme.layout_magnifier              = theme.icon_dir .. "/magnifier.png"
theme.layout_floating               = theme.icon_dir .. "/floating.png"
theme.layout_centerwork             = theme.icon_dir .. "/centerwork.png"
theme.layout_centerworkd            = theme.icon_dir .. "/centerwork.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = false
theme.tasklist_maximized_vertical   = true

-- lain related
theme.useless_gap_width             = 5
theme.layout_uselesstile            = theme.icon_dir .. "/uselesstile.png"
theme.layout_uselesstileleft        = theme.icon_dir .. "/uselesstileleft.png"
theme.layout_uselesstiletop         = theme.icon_dir .. "/uselesstiletop.png"

return theme
