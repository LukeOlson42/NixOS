{ config, pkgs, inputs, lib, ... }:
let
    mkSwitchWkspCmds =
        builtins.concatLists (builtins.genList (i:
        let ws = i + 1; in
            [
                # "$mainMod, code:1${toString i}, workspace, ${toString ws}"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + ${toString i}\"")
                        (lib.generators.mkLuaInline "hl.dsp.focus({workspace = ${toString ws}})")
                    ];
                }
            ]
        ) 9);

    mkMvWindowCmds =
        builtins.concatLists (builtins.genList (i:
        let ws = i + 1; in
            [
                # "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + ${toString i}\"")
                        (lib.generators.mkLuaInline "hl.dsp.window.move({workspace = ${toString ws}})")
                    ];
                }
            ]
        ) 9);
in
{
    home = {
		packages = with pkgs; [
            libnotify
            rofi
            brightnessctl
            hyprshot
            pavucontrol
		];
    };

    xdg = {
        mime.enable = true;
        mimeApps.defaultApplications = {
            "text/html" = "firefox.desktop";
        };
    };

    services.mako.settings = {
        enable = true;
        font = "JetBrains Mono NerdFont 8";
        defaultTimeout = 10000;
        backgroundColor = "#282828";
        borderColor = "#8ec07c";
        textColor = "#ebdbb2";
        borderRadius = 5;
        format = "%s\\n%b";
    };

    home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 8;
    };

    programs.rofi = {
        enable = true;
        terminal = "alacritty";
        font = "JetBrains Mono Nerd Font 12";
        theme = ./rofi/launcher.rasi;
    };

    services.wpaperd = {
        enable = true;
        settings = {
            default = {
                duration = "30m";
                sorting = "random";
                mode = "center";
            };

            any = {
                path = "${config.home.homeDirectory}/NixOS/wallpapers";
            };
        };
    };

    programs.waybar = {
        enable = true;        
        style = ./waybar/style.css;
        settings = [{
            layer = "bottom";
            modules-left =  ["hyprland/workspaces"];
            modules-center = [ "custom/logo" ];
            modules-right = [
                "tray"
                "cpu"
                "memory"
                "idle_inhibitor"
                "network"
                "pulseaudio"
                # Removed for now, maybe we can configure based on build name?
                # "backlight"
                # "battery"
                "clock"
            ];
            "hyprland/workspaces" = {
                format = "{icon}";
                on-scroll-up   = "hyprctl dispatch workspace e+1";
                on-scroll-down = "hyprctl dispatch workspace e-1";
            };
            "custom/logo" = {
                format = " ";
                on-click = "~/NixOS/components/hyprland/rofi/powermenu.sh";
            };
            idle_inhibitor = {
                format = "{icon}";
                format-icons = {
                    activated = " ";
                    deactivated = " ";
                };
                tooltip-format-activated = "Idle Inhibited";
                tooltip-format-deactivated = "Idle Not Inhibited";
            };
            tray = {
                spacing = 10;
            };
            clock = {
                interval = 1;
                format = "{:%m/%d/%y - %H:%M:%S}";
                format-alt = "{:%A, %B %d, %Y (%R)}";
            };
            cpu = {
                format = "CPU: {usage}%";
            };
            memory = {
                format = "RAM: {used}/{total}GB";
            };
            # backlight = {
            #     # device = "intel_backlight";
            #     format = "　{percent}%";
            #     format-icons = ["" ""];
            # };
            # battery = {
            #     format = "　{capacity}%";
            # };
            network = {
                format-wifi = "WiFi: {signalStrength}%";
                format-ethernet = "{ifname}";
                format-disconnected = "";
                tooltip-format = "{ifname} via {gwaddr}";
            };
            pulseaudio = {
                # scroll-step = 1,
                format = "　{volume}%";
                format-muted = "Mute";
                format-icons = {
                    headphones = "";
                    phone = "";
                    default = ["" ""];
                };
                on-click = "pavucontrol";
            };
        }];
    };

    services.gammastep = {
        enable = true;
        # dawnTime = "07:00";
        # duskTime = "19:00";
        latitude = "42.9704";
        longitude = "-85.6722";
        temperature = {
            day = 5700;
            night = 3000;
        };
        tray = true;
    };

    wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        package = null;
        portalPackage = null;

        settings = {
            mainMod = {
                _var = "ALT";
            };

            winShift = {
                _var = "SUPER + SHIFT";
            };

            terminal = {
                _var = "alacritty";
            };

            browser = {
                _var = "firefox";
            };

            editor = {
                _var = "nvim";
            };

            fileManager = {
                _var = "nemo";
            };

            menu = {
                _var = "rofi -show drun";
            };

            ssLocation = {
                _var = "~/screenshots/";
            };

            # Keybinds !!
            bind = [
                # General Keybinds
                # "$mainMod, Return, exec, [float] $terminal"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + Return\"")
                        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(terminal)")
                        (lib.generators.mkLuaInline "hl.dsp.window.float({ action = toggle })")
                    ];
                }
                # "$mainMod, M, exit"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + M\"")
                        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprshutdown\")")
                    ];
                }
                # "$mainMod, SPACE, exec, $menu"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + SPACE\"")
                        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(menu)")
                    ];
                }
                # "$mainMod, Q, killactive"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + Q\"")
                        (lib.generators.mkLuaInline "hl.dsp.window.close()")
                    ];
                }

                # "$mainMod, A, togglefloating"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + A\"")
                        (lib.generators.mkLuaInline "hl.dsp.window.float({ action = toggle })")
                    ];
                }
                # "$mainMod, B, fullscreen, 0"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + A\"")
                        (lib.generators.mkLuaInline "hl.dsp.window.fullscreen({
                            mode = \"maximized\",
                            action = \"toggle\",
                            window = 0,
                        })")
                    ];
                }
                # "$winShift, S, exec, hyprshot -o $ssLocation -m region"
                {
                    _args = [
                        (lib.generators.mkLuaInline "winShift .. \" + S\"")
                        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprshot -o \" .. ssLocation .. \" -m region\")")
                    ];
                }
                # "$mainMod, L, exec, hyprlock"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + L\"")
                        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprlock\")")
                    ];
                }
                # "$mainMod, C, exec, [float] qalculate-qt"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + C\"")
                        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"qalculate-qt\")")
                        (lib.generators.mkLuaInline "hl.dsp.window.float({ action = toggle })")
                    ];
                }
                # "$mainMod, O, exec, [float] nemo"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + O\"")
                        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"nemo\")")
                        (lib.generators.mkLuaInline "hl.dsp.window.float({ action = toggle })")
                    ];
                }

                # Movement Keybinds
                # "$mainMod, h, movefocus, l"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + h\"")
                        (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"left\" })")
                    ];
                }
                # "$mainMod, j, movefocus, d"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + j\"")
                        (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"down\" })")
                    ];
                }
                # "$mainMod, k, movefocus, u"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + k\"")
                        (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"up\" })")
                    ];
                }
                # "$mainMod, l, movefocus, r"
                {
                    _args = [
                        (lib.generators.mkLuaInline "mainMod .. \" + l\"")
                        (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"right\" })")
                    ];
                }

                # "$mainMod SHIFT, h, movewindow, l"
                # "$mainMod SHIFT, j, movewindow, d"
                # "$mainMod SHIFT, k, movewindow, u"
                # "$mainMod SHIFT, l, movewindow, r"

                # tab cycling
                # "$mainMod, Tab, cyclenext"
                # "$mainMod, Tab, bringactivetotop"
            ] ++ mkMvWindowCmds ++ mkSwitchWkspCmds;

            # bindm = [
            #     # Move and Resize Windows
            #     "$mainMod, mouse:272, movewindow"
            #     "$mainMod, mouse:273, resizewindow"
            #     ", mouse:276, movewindow"
            #     ", mouse:275, resizewindow"
            # ];

            # binde = [
            #     ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
            #     ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
            #     ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
            #     ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
            #     ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
            # ];

            window_rule = [
                {
                    name = "Steam Friends Float";
                    match.class = "Steam";
                    match.title = "^(Friends List)$";
                    float = true;
                }
                {
                    name = "Player on Top";
                    match.title = "^(Picture-in-Picture)$";
                    float = true;
                    pin = true;
                }
                {
                    name = "wayland video bridge?";
                    match.class = "^(xwaylandvideobridge)$";
                    suppress_event = "maximize";
                    opacity = "0.0 override";
                    no_anim = true;
                    no_initial_focus = true;
                    no_blur = true;
                    no_focus = true;
                    max_size = "{ 1, 1 }";
                }
                {
                    name = "stop maximize?";
                    match.class = ".*";
                    suppress_event = "maximize";
                }
            ];

            config = {
                decoration = {
                    rounding = 5;
                    active_opacity = 1.0;
                    inactive_opacity = 0.9;
                };

                input = {
                    kb_layout = "us";
                    accel_profile = "flat";
                    sensitivity = 0.0;
                    follow_mouse = 1;
                    kb_options = "ctrl:nocaps";
                    repeat_delay = 250;
                };

                dwindle = {
                    # pseudotile = true;
                    preserve_split = true;
                };

                misc = {
                    disable_hyprland_logo = true;
                    animate_mouse_windowdragging = true;
                    initial_workspace_tracking = 2;
                };

                general = {
                    gaps_in = 2;
                    gaps_out = 10;
                    border_size = 2;

                    col.active_border = (lib.generators.mkLuaInline "{ colors = { \"rgba(8ec07cff)\", \"rgba(689d6aff)\" }, angle = 60 }");

                    # not gruvbox gray, but pretty nice 
                    col.inactive_border = "0x595959aa";

                    resize_on_border = false;
                };
            };

            # Startup Programs !!
            on = {
                _args = [
                    "hyprland.start"
                    (lib.generators.mkLuaInline "function()
                        hl.exec_cmd(\"wpaperd\")
                        hl.exec_cmd(\"waybar\")
                        hl.exec_cmd(\"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP\")
                     end")
                ];
            };

            # This may have to change between machines, later problem
            monitor = {
               output = "eDP-1";
               mode = "2560x1440@200";
               position = "0x0";
               scale = 1;
               bitdepth = 10;
            };
        };
    };
    
    services.hypridle = {
        enable = true;
        settings = {
            listener = [
                {
                    timeout = 600;
                    on-timeout = "exec hyprlock";
                }
            ];
        };
    };

    programs.hyprlock = {
        enable = true;
        settings = {
            general = {
                disable_loading_bar = true;
                grace = 0;
                hide_cursor = false;
                no_fade_in = false;
                no_fade_out = false;
            };

            background = [
                {
                    path =  "${config.home.homeDirectory}/NixOS/wallpapers/jungle_mountains.jpg";
                    blur_passes = 2;
                    blur_size = 8;
                }
            ];

            input-field = [
                {
                    monitor = "";
                    size = "188, 45";
                    outline_thickness = 2;
                    dots_size = 0.2;
                    dots_spacing = 0.35;
                    dots_center = true;
                    outer_color = "rgba(0, 0, 0, 0)";
                    inner_color = "rgba(0, 0, 0, 0.2)";
                    font_color = "rgb(235, 219, 178)";
                    fade_on_empty = false;
                    rounding = -1;
                    check_color = "rgb(251, 73, 52)";
                    placeholder_text = "<i><span foreground=\"##ebdbb2\">Input Password...</span></i>";
                    position = "0, -200";
                    halign = "center";
                    valign = "center";
                }
            ];

# #ebdbb2
            label = [
                # Clock
                {
                    monitor = "";
                    text = "cmd[update:1000] date +\"%-I:%M%p\"";
                    color = "rgba(235, 219, 178, 0.75)";
                    font_size = 95;
                    font_family = "JetBrains Mono Nerd Font Extrabold";
                    position = "0, 200";
                    halign = "center";
                    valign = "center";
                }
                # Date
                {
                    monitor = "";
                    text = "cmd[update:1000] date +\"%A, %B %d\"";
                    color = "rgba(235, 219, 178, 0.75)";
                    font_size = 22;
                    font_family = "JetBrains Mono Nerd Font";
                    position = "0, 300";
                    halign = "center";
                    valign = "center";
                }
            ];
        };
    };
}
