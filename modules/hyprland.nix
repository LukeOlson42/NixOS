{ config, pkgs, ... }:

{
    home = {
		packages = with pkgs; [
            waybar
            mako
            libnotify
            rofi-wayland
		];
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
                sorting = "ascending";
                mode = "center";
            };

            any = {
                path = "${config.home.homeDirectory}/NixOS/modules/wallpapers";
            };
        };
    };

    wayland.windowManager.hyprland = {
        enable = true;
        # Display Server !!
        # xwayland.enable = true;
        settings = {
            # Hyprland Variables !!
            "$mainMod" = "SUPER";
            "$mod" = "SUPER";
            "$terminal" = "alacritty";
            "$browser" = "firefox";
            "$editor" = "nvim";
            "$fileManager" = "yazi";
            "$menu" = "rofi -show drun";

            # Keybinds !!
            bind = [
                "$mainMod, F, exec, $browser"
                "$mainMod, O, exec, $fileManager"
                "$mainMod, Q, exec, $terminal"
                "$mainMod, M, exit"
                "$mainMod, R, exec, $menu"
                "$mainMod, C, killactive"
            ] ++ (
                builtins.concatLists (builtins.genList (i:
                    let ws = i + 1;
                    in [
                        "$mainMod, code:1${toString i}, workspace, ${toString ws}"
                    ]
                ) 9)
            );

            bindm = [
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];

            misc = {
                disable_hyprland_logo = true;
                animate_mouse_windowdragging = true;
            };

            # Startup Programs !!
            exec-once = [
                "wpaperd"
            ];

        };
    };
}
