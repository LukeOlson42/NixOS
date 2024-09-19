{ config, pkgs, ... }:

{
#    home = {
#		packages = with pkgs; [
#            waybar
#            mako
#            libnotify
#            swww
#            rofi-wayland
#		];
#    };

    # programs.kitty.enable = true;
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            "$mod" = "SUPER";
            bind = [
                "$mod, F, exec, firefox"
            ] ++ (
                builtins.concatLists (builtins.genList (i:
                    let ws = i + 1;
                    in [
                        "$mod, code:1${toString i}, workspace, ${toString ws}"
                    ]
                ) 9)
            );
        };
    };
}
