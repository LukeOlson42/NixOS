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
            mako
            libnotify
            rofi-wayland
		];
    };

    home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 10;
    };

    programs.rofi = {
        enable = true;
        terminal = "alacritty";
        font = "Iosevka 10";
        theme = "gruvbox-dark";
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
                path = "${config.home.homeDirectory}/NixOS/modules/wallpapers";
            };
        };
    };

    programs.waybar = {
        enable = true;        
        style = ./waybar/style.css;
        settings = [{
            layer = "top";
            modules-left =  ["hyprland/workspaces" "tray"];
            modules-center = [ "custom/logo" ];
            modules-right = [
                "cpu"
                "memory"
                "backlight"
                "network"
                "pulseaudio"
                "battery"
                "clock"
            ];
            "hyprland/workspaces" = {
                format = "{icon}";
                on-scroll-up   = "hyprctl dispatch workspace e+1";
                on-scroll-down = "hyprctl dispatch workspace e-1";
            };
            "custom/logo" = {
                format = " ";
            };
            tray = {
                # "icon-size" = 21,
                spacing = 10;
            };
            clock = {
                tooltip-format = "{:%m-%d-%Y | %H:%M}";
                format-alt = "{:%Y-%m-%d}";
                format = "{:%a %m-%d-%Y - %H:%M %p}";
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
                format-ethernet = "{ifname}: {ipaddr}/{cidr} ethernet";
                format-disconnected = "Down";
            };
            pulseaudio = {
                # scroll-step = 1,
                format = "　{volume}%";
                format-bluetooth = "{volume}% {icon}";
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

    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            # Hyprland Variables !!
            "$mainMod" = "ALT";
            "$mod" = "SUPER";
            "$terminal" = "alacritty";
            "$browser" = "firefox";
            "$editor" = "nvim";
            "$fileManager" = "yazi";
            "$menu" = "rofi -show drun";

            # Keybinds !!
            bind = [
                # General Keybinds
                "$mainMod, F, exec, $browser"
                "$mainMod, O, exec, $terminal -e $fileManager"
                "$mainMod, T, exec, $terminal"
                "$mainMod, M, exit"
                "$mainMod, R, exec, $menu"
                "$mainMod, Q, killactive"
                "$mainMod, V, togglefloating"
                "$mainMod, J, togglesplit"
                "$mainMod, P, pseudo"

                # Movement Keybinds
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"
                "$mainMod, h, movefocus, l"
                "$mainMod, j, movefocus, d"
                "$mainMod, k, movefocus, u"
                "$mainMod, l, movefocus, r"
            ] ++ mkMvWindowCmds ++ mkSwitchWkspCmds;

            bindm = [
                # Move and Resize Windows
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
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

            "windowrulev2" = "suppressevent maximize, class:.*";

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
            };

            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };

            # Startup Programs !!
            exec-once = [
                "wpaperd"
                "waybar"
            ];

            monitor = "eDP-1, 1920x1080@60, 0x0, 1.2";
        };
    };
}
