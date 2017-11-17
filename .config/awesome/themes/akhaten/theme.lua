
--[[ The rings of Akhaten --]]

col0 = '#00000030'
col1 = '#331E2F'
col2 = '#7C2A0D'
col3 = '#571107'
col4 = '#4D0E16'
col5 = '#ED5F03'
col6 = '#FCEF71'
col7 = '#e8e8e8'
col8 = '#00000070'


theme                               = {}
theme.icon_dir                      = os.getenv("HOME") .. "/.config/awesome/themes/akhaten/icons"
theme.wallpaper                     = os.getenv("HOME") .. "/.config/awesome/themes/akhaten/wall.png"
theme.font                          = "DejaVu Sans Mono 8"
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
theme.bg_normal                     = col0
theme.bg_urgent                     = col0
theme.tasklist_bg_normal            = col0

-- Focus
theme.taglist_bg_focus              = "png:" .. theme.icon_dir .. "/taglist_bg_focus.png"
theme.tasklist_bg_focus             = "png:" .. theme.icon_dir .. "/bg_focus.png"

theme.border_focus                  = col5
theme.border_width                  = "1"
theme.border_normal                 = col1

theme.textbox_widget_margin_top     = 1
theme.awful_widget_height           = 14
theme.awful_widget_margin_top       = 2
theme.menu_height                   = "20"
theme.menu_width                    = "400"

-- tooltip
tooltip_font                        = "DejaVu Sans Mono 8"
-- tooltip_opacity =
tooltip_fg_color                    = col7
tooltip_bg_color                    = col1
tooltip_border_width                = "1"
tooltip_border_color                = col5

theme_menu_bg_color                       = col1
theme_menu_fg_color                       = col7
theme_menu_bg_focus                       = col1
theme_menu_fg_focus                       = col5
theme_menu_border_color                   = col5
theme_menu_border_size                    = 1

theme.taglist_fg_focus    = "#FFFFFF"
theme.taglist_fg_occupied = "#828282"
theme.taglist_fg_urgent   = "#ED7572"
theme.taglist_fg_empty    = "#828282"
theme.taglist_spacing     = 2


-- theme.widget_bg                     = theme.icon_dir .. "/bg_focus_noline.png"
theme.awesome_icon                  = theme.icon_dir .. "/awesome_icon.png"
--theme.vol_bg                        = theme.icon_dir .. "/vol_bg.png"
--theme.submenu_icon                  = theme.icon_dir .. "/submenu.png"
-- Squares around taglist
theme.taglist_squares_sel           = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel         = theme.icon_dir .. "/square_unsel.png"

--theme.last                          = theme.icon_dir .. "/last.png"
--theme.spr                           = theme.icon_dir .. "/spr.png"
-- theme.spr_small                     = theme.icon_dir .. "/spr_small.png"
--theme.spr_very_small                = theme.icon_dir .. "/spr_very_small.png"
-- theme.spr_right                     = theme.icon_dir .. "/spr_right.png"
-- theme.spr_bottom_right              = theme.icon_dir .. "/spr_bottom_right.png"
-- theme.spr_left                      = theme.icon_dir .. "/spr_left.png"
-- theme.bar                           = theme.icon_dir .. "/bar.png"
-- theme.bottom_bar                    = theme.icon_dir .. "/bottom_bar.png"
--theme.mpd                           = theme.icon_dir .. "/mpd.png"
--theme.mpd_on                        = theme.icon_dir .. "/mpd_on.png"
--theme.prev                          = theme.icon_dir .. "/prev.png"
--theme.nex                           = theme.icon_dir .. "/next.png"
--theme.stop                          = theme.icon_dir .. "/stop.png"
--theme.pause                         = theme.icon_dir .. "/pause.png"
--theme.play                          = theme.icon_dir .. "/play.png"
--theme.clock                         = theme.icon_dir .. "/new/clock.png"
--theme.calendar                      = theme.icon_dir .. "/cal.png"
--theme.cpu                           = theme.icon_dir .. "/cpu.png"
--theme.net_up                        = theme.icon_dir .. "/net_up.png"
--theme.net_down                      = theme.icon_dir .. "/net_down.png"
--theme.widget_mail_notify            = theme.icon_dir .. "/mail_notify.png"

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

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = false
theme.tasklist_maximized_vertical   = true

-- lain related
theme.useless_gap_width             = 10
theme.layout_uselesstile            = theme.icon_dir .. "/uselesstile.png"
theme.layout_uselesstileleft        = theme.icon_dir .. "/uselesstileleft.png"
theme.layout_uselesstiletop         = theme.icon_dir .. "/uselesstiletop.png"

return theme
