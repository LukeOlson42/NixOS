{ config, lib, pkgs, ... }:

{
	programs.alacritty = {
		enable = true;
		settings = {
			font = {
				size = 12;
				normal.family = "Iosevka Nerd Font";
				bold.family = "Iosevka Nerd Font";
				italic.family = "Iosevka Nerd Font";
			};

            colors = {
                primary = {
                    background = "#282828";
                    foreground = "#ebdbb2";
                };

                normal = {
                    black = "#282828";
                    red = "#cc241d";
                    green = "#98971a";
                    yellow = "#d79921";
                    blue = "#458588";
                    magenta = "#b16286";
                    cyan = "#689d6a";
                    white = "#a89984";
                };

                bright = {
                    black = "#928374";
                    red = "#fb4934";
                    green = "#b8bb26";
                    yellow = "#fadb2f";
                    blue = "#83a598";
                    magenta = "#d3869b";
                    cyan = "#8ec07c";
                    white = "#ebdbb2";
                };
            };

            mouse.bindings = [
                { "mouse" = "Right"; "action" = "Paste"; }
            ];

            cursor.style = "Block";

			shell.program = "zsh";
            window.opacity = 0.9;
		};
	};
}
