{ config, pkgs, ... }:

{
    home = {
		packages = with pkgs; [
            waybar
            mako
            libnotify
            swww
            rofi-wayland
		];
    };

    programs.kitty.enable = true;
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            "$mainMod" = "SUPER";
            "$terminal" = "alacritty";
            "$browser" = "firefox";
            "$editor" = "nvim";
            "$fileManager" = "yazi";
            bind = [
                "$mainMod, f, exec, firefox"
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
