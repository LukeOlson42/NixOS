{ config, pkgs, ... }:

{
    home = {
		packages = with pkgs; [
            waybar
            mako
            libnotify
            swww
		];
    };

    programs.rofi = {
        enable = true;
        terminal = "alacritty";
        font = "Iosevka 12";
        theme = "gruvbox-dark";
    };

    programs.kitty.enable = true;
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            "$mainMod" = "SUPER";
            "$mod" = "SUPER";
            "$terminal" = "alacritty";
            "$browser" = "firefox";
            "$editor" = "nvim";
            "$fileManager" = "yazi";
            "$menu" = "rofi -show drun";
            bind = [
                "$mainMod, F, exec, $browser"
                "$mainMod, O, exec, $fileManager"
                "$mainMod, Q, exec, $terminal"
                "$mainMod, M, exec, exit"
                "$mainMod, R, exec, $menu"
            ] ++ (
                builtins.concatLists (builtins.genList (i:
                    let ws = i + 1;
                    in [
                        "$mainMod, code:1${toString i}, workspace, ${toString ws}"
                    ]
                ) 9)
            );
        };
    };
}
