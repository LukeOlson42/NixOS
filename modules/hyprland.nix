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
        font = "Iosevka";
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
            bind = [
                "$mainMod, f, exec, $browser"
                "$mainMod, o, exec, $fileManager"
                "$mainMod, q, exec, $terminal"
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
