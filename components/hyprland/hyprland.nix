{ config, pkgs, ... }:
let
    mkSwitchWkspCmds =
        builtins.concatLists (builtins.genList (i:
        let ws = i + 1; in
            [
                "$mainMod, code:1${toString i}, workspace, ${toString ws}"
            ]
        ) 9);

    mkMvWindowCmds =
        builtins.concatLists (builtins.genList (i:
        let ws = i + 1; in
            [
                "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
        ) 9);
in
{
    home = {
		packages = with pkgs; [
            libnotify
            rofi-wayland
            brightnessctl
            hyprshot
            pavucontrol
		];
    };

    services.mako = {
        enable = true;
        font = "JetBrains Mono 8";
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
        font = "JetBrains Mono 12";
        theme = ./rofi/launcher.rasi;
        package = pkgs.rofi-wayland;
    };

    programs.wpaperd = {
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
#             "custom/spotify" = {
#                 exec = "~/NixOS/components/hyprland/waybar/spotify/metadata.sh";
#                 max-length = 40;
#                 return-type = "json";
#                 format = "{} ";
#                 on-click = "~/NixOS/components/hyprland/waybar/spotify/controls.sh";
#                 on-scroll-up = "~/NixOS/components/hyprland/waybar/spotify/controls.sh next ";
#                 on-scroll-down = "~/NixOS/components/hyprland/waybar/spotify/controls.sh previous";
#                 signal = 5;
#                 smooth-scrolling-threshold = 1.0;
#                 interval = 60;
#             };
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
                format = "{:%H:%M:%S}";
                format-alt = "{:%A, %B %d, %Y (%R)}";
            };
            cpu = {
                format = "CPU: {usage}%";
            };
            memory = {
                format = "RAM: {}%";
            };
            backlight = {
                # device = "intel_backlight";
                format = "　{percent}%";
                format-icons = ["" ""];
            };
            battery = {
                format = "　{capacity}%";
            };
            network = {
                format-wifi = "WiFi: {signalStrength}%";
                format-ethernet = "{bandwidthDownBits}   {bandwidthUpBits}  ";
                format-disconnected = "Down";
                interval = 1;
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
        latitude = 42.972218;
        longitude = 85.951547;
    };

    wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = true;
        settings = {
            # Hyprland Variables !!
            "$mainMod" = "ALT";
            "$winShift" = "SUPER_SHIFT";
            "$mod" = "SUPER";
            "$terminal" = "alacritty";
            "$browser" = "firefox";
            "$editor" = "nvim";
            "$fileManager" = "yazi";
            "$menu" = "rofi -show drun";
            "$ssLocation" = "~/screenshots/";

            # Keybinds !!
            bind = [
                # General Keybinds
                "$mainMod, O, exec, $terminal -e $fileManager"
                "$mainMod, Return, exec, $terminal"
                "$mainMod, M, exit"
                "$mainMod, SPACE, exec, $menu"
                "$mainMod, Q, killactive"
                "$mainMod, V, togglefloating"
                "$mainMod, J, togglesplit"
                "$mainMod, P, pseudo"
                "$winShift, S, exec, hyprshot -o $ssLocation -m region"
                "$mod, L, exec, hyprlock"
                "$mainMod, C, exec, [floating] qalculate-qt"

                # Movement Keybinds
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"

                "$mainMod, h, movefocus, l"
                "$mainMod, j, movefocus, d"
                "$mainMod, k, movefocus, u"
                "$mainMod, l, movefocus, r"

                "$mainMod SHIFT, h, movewindow, l"
                "$mainMod SHIFT, j, movewindow, d"
                "$mainMod SHIFT, k, movewindow, u"
                "$mainMod SHIFT, l, movewindow, r"

                "$mainMod SUPER, h, resizeactive, -20 0"
                "$mainMod SUPER, j, resizeactive, 0 20"
                "$mainMod SUPER, k, resizeactive, 0 -20"
                "$mainMod SUPER, l, resizeactive, 20 0"

                # tab cycling
                "$mainMod, Tab, cyclenext"
                "$mainMod, Tab, bringactivetotop"
            ] ++ mkMvWindowCmds ++ mkSwitchWkspCmds;

            bindm = [
                # Move and Resize Windows
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
                ", mouse:276, movewindow"
                ", mouse:275, resizewindow"
            ];

            binde = [
                ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
                ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
                ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
                ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
                ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
            ];

            misc = {
                disable_hyprland_logo = true;
                animate_mouse_windowdragging = true;
            };

            general = {
                allow_tearing = false;
                layout = "dwindle";
                gaps_in = 2;
                gaps_out = 10;
                border_size = 2;

                "col.active_border" = "rgba(8ec07cff) rgba(689d6aff) 60deg";
                # not gruvbox gray, but pretty nice 
                "col.inactive_border" = "rgba(595959aa)";

                resize_on_border = false;
            };

            # Do we need this?
            "windowrulev2" = [
                "suppressevent maximize, class:.*"
                "opacity 0.0 override, class:^(xwaylandvideobridge)$"
                "noanim, class:^(xwaylandvideobridge)$"
                "noinitialfocus, class:^(xwaylandvideobridge)$"
                "maxsize 1 1, class:^(xwaylandvideobridge)$"
                "noblur, class:^(xwaylandvideobridge)$"
                "nofocus, class:^(xwaylandvideobridge)$"
            ];

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
                pseudotile = true;
                preserve_split = true;
            };

            # Startup Programs !!
            exec-once = [
                "wpaperd"
                "waybar"
                "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            ];

            # This may have to change between machines, later problem
            monitor = "eDP-1, 1920x1080@60, 0x0, 1, bitdepth, 10";
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
                    font_family = "JetBrains Mono Extrabold";
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
                    font_family = "JetBrains Mono";
                    position = "0, 300";
                    halign = "center";
                    valign = "center";
                }
                # Current Song
                {
                    monitor = "";
                    text = "cmd[update:1000] echo \"$(~/NixOS/components/hyprland/waybar/spotify/metadata.sh query)\"";
                    color = "rgba(235, 219, 178, 0.75)";
                    font_size = 14;
                    font_family = "JetBrains Mono";
                    position = "0, 20";
                    halign = "center";
                    valign = "bottom";
                }
            ];
        };
    };
}
