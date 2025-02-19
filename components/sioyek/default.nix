{ config, lib, pkgs, ... }:

{
    programs.sioyek = {
        enable = true;
        bindings = {
            "move_up" = "k";
            "move_down" = "j";
            "move_left" = "h";
            "move_right" = "l";
            "screen_down" = [ "n" "<C-n>" ];
            "screen_up" = [ "p" "<C-p>" ];
        };
    };
}
